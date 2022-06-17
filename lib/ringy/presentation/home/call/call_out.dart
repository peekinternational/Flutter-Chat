import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_call.dart';
import 'package:flutter_chat/ringy/presentation/home/call/join_call.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../domain/entities/socket_models/socket_call_status.dart';
import '../../../domain/entities/socket_models/socket_delete_message.dart';
import '../../../infrastructure/data_sources/api_data_source.dart';
import '../../../resources/shared_preference.dart';
import '../../core/socket/users_socket_utils.dart';

class CallOutPage extends StatefulWidget {
  String? receiverName;
  String? receiverId;
  String? receiverImage;
  List<String?>? fcmIdList;
  bool? groupCall;

  CallOutPage(this.receiverName, this.receiverId, this.receiverImage,
      this.fcmIdList, this.groupCall,
      {Key? key})
      : super(key: key);

  @override
  _CallOutPageState createState() => _CallOutPageState();
}

class _CallOutPageState
    extends State<CallOutPage> /*implements SocketEventsCall*/ {
  String callingText = StringsEn.calling;
  ApiDataSource apiDataSource = ApiDataSource();
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;
  bool callJoined = false;

  final joinCall = JoinCall();
  String? id = Prefs.getString(Prefs.myUserId);

  @override
  void initState() {
    super.initState();
    sendCallNotification(StringsEn.call);
    initializeMeeting();
    endCallNotPickedInTime();
  }

  @override
  void dispose() {
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
            setTextField(widget.receiverName!, smallText: false),
            const Spacer(flex: 10),
            setTextField(callingText),
            const Spacer(flex: 40),
            ImageOrFirstCharacterCall(
              imageUrl: widget.receiverImage!,
              name: widget.receiverName!,
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

  Widget setTextField(String receiverName, {bool smallText = true}) {
    return Text(
      receiverName,
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
            setState(() {
              isAudioMuted = !isAudioMuted!;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: isAudioMuted!
                    ? const Color(0xffD64467)
                    : const Color(0xffffffff),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.06),
                      offset: const Offset(0, 4)),
                ]),
            width: 72,
            height: 72,
            child: Icon(
              isAudioMuted! ? Icons.mic_off_sharp : Icons.mic_none_sharp,
              color: isAudioMuted! ? Colors.white : Colors.black,
            ),
          ),
        ),
        const Spacer(flex: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              // isVideoMuted = !isVideoMuted!;
              sendCallNotification("cancelAll");
              joinCall.callAcceptedStatusFromReceiver(id!, "0", false);
              Navigator.of(context).pop();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: const Color(0xffD64467),
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
        const Spacer(flex: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              isVideoMuted = !isVideoMuted!;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: isVideoMuted!
                    ? RingyColors.callRejectButtonColor
                    : const Color(0xffffffff),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.06),
                      offset: const Offset(0, 4)),
                ]),
            width: 72,
            height: 72,
            child: Icon(
              isVideoMuted! ? Icons.videocam_off_sharp : Icons.videocam,
              color: isVideoMuted! ? Colors.white : Colors.black,
            ),
          ),
        ),
        const Spacer(flex: 32),
      ],
    );
  }

  void endCallNotPickedInTime() {
    Future.delayed(
      const Duration(seconds: 30),
      () {
        if (!callJoined) {
          sendCallNotification("cancelAll");
          joinCall.callAcceptedStatusFromReceiver(id!, "0", false);
        }
      },
    );
  }

  void sendCallNotification(String title) {
    apiDataSource.sendNotification(
        widget.fcmIdList,
        title,
        "${Prefs.getString(Prefs.myName)!} is calling",
        StringsEn.callNotification,
        widget.groupCall!);
  }

  void initializeMeeting() {
    joinCall.initMeeting(
        (pickingCallData) => getCallData(pickingCallData, context),
        (terminateCall) => {
              if (terminateCall) {context.router.pop()}
            },
        false);
  }

  void getCallData(data, BuildContext context) {
    setState(() {
      Map<String, dynamic> socketData = jsonDecode(jsonEncode(data));
      var wholeJson = SocketCallStatus.fromJson(socketData);
      if (wholeJson.status == "1" && wholeJson.id == widget.receiverId) {
        String? text = Prefs.getString(Prefs.myName);
        joinCall.joinMeeting("", widget.receiverName!, widget.receiverName!,
            text!, true, isAudioMuted, isVideoMuted);
        callJoined = true;
      } else if (wholeJson.status == "2") {
        callingText = StringsEn.ringing;
      } else {
        joinCall.closeCall();
        context.router.pop();
      }
    });
  }
}
