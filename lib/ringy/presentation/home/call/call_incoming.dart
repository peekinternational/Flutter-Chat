import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_call.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../domain/entities/socket_models/socket_call_status.dart';
import '../../../infrastructure/data_sources/api_data_source.dart';
import '../../../resources/shared_preference.dart';
import '../../core/socket/users_socket_utils.dart';
import '../../core/utils/helper_models.dart';
import '../../core/utils/socket_helper.dart';
import 'join_call.dart';

class CallIncomingPage extends StatefulWidget {
  String? senderName;
  String? senderId;
  String? senderImage;

  CallIncomingPage(this.senderName, this.senderId, this.senderImage, {Key? key})
      : super(key: key);

  @override
  _CallIncomingPageState createState() => _CallIncomingPageState();
}

class _CallIncomingPageState extends State<CallIncomingPage> {
  String callingText = StringsEn.incomingCall;
  ApiDataSource apiDataSource = ApiDataSource();
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;
  final joinCall = JoinCall();

  @override
  void initState() {
    super.initState();
    joinCall.initMeeting(
      (pickCallDate) => {
        endCall(pickCallDate, context)
      },
      (terminateCall) => {
        if (terminateCall) {context.router.pop()}
      },true
    );
  }

  endCall(data, BuildContext context) {
    setState(() {
      Map<String, dynamic> socketData = jsonDecode(jsonEncode(data));
      var wholeJson = SocketCallStatus.fromJson(socketData);
      if (wholeJson.status == "0" /*&& wholeJson.id == widget.senderId*/) {
        context.router.pop();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    joinCall.removeListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: RingyColors.overlay,
        ),
        backgroundColor: RingyColors.overlay,
      ),
      backgroundColor: RingyColors.overlayCall,
      body: Container(
        color: RingyColors.overlayCall,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 30),
            setTextField(widget.senderName!, smallText: false),
            const Spacer(flex: 10),
            setTextField(callingText),
            const Spacer(flex: 40),
            ImageOrFirstCharacterCall(
              imageUrl: widget.senderImage!,
              name: widget.senderName!,
              radius: 72,
            ),
            const Spacer(flex: 40),
            bottomButtons(),
            const Spacer(flex: 15),
          ],
        ),
      ),
    );
  }

  Widget setTextField(String senderName, {bool smallText = true}) {
    return Text(
      senderName,
      style: TextStyle(
          color: Colors.white,
          fontSize: smallText ? 14 : 22,
          fontWeight: smallText ? FontWeight.normal : FontWeight.bold),
    );
  }

  Widget bottomButtons() {
    return Row(
      children: [
        const Spacer(flex: 32),
        GestureDetector(
          onTap: () {
            callStatus("1");
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: RingyColors.callAcceptButtonColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.06),
                      offset: const Offset(0, 4)),
                ]),
            width: 72,
            height: 72,
            child: const Icon(Icons.call, color: Colors.white),
          ),
        ),
        const Spacer(flex: 48),
        GestureDetector(
          onTap: () {
            setState(() {
              callStatus("0");
              context.router.pop();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: RingyColors.callRejectButtonColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.06),
                      offset: const Offset(0, 4)),
                ]),
            width: 72,
            height: 72,
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(flex: 32),
      ],
    );
  }

  void callStatus(String status) {
    setState(() {
      String? text = Prefs.getString(Prefs.myName);
      String? id = Prefs.getString(Prefs.myUserId);
      joinCall.callAcceptedStatusFromReceiver(id!,status,false);
      if (status == "1") {
        joinCall.joinMeeting(
            "", text!, text, text, true, isAudioMuted, isVideoMuted);
      }
    });
  }
}
