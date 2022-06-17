import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/presentation/home/call/call_ui.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../../../resources/strings_en.dart';
import '../../core/utils/helper_models.dart';
import '../chat/o2o/chat/message_views_widgets/items.dart';

class Meeting extends StatefulWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: Prefs.getString(Prefs.myName));
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = false;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Plugin example app'),
        // ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.30,
                      // child: meetConfig(),
                    ),
                    Container(
                        width: width * 0.60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: Colors.white54,
                              child: SizedBox(
                                width: width * 0.60 * 0.70,
                                height: width * 0.60 * 0.70,
                                child: JitsiMeetConferencing(
                                  extraJS: [
                                    // extraJs setup example
                                    '<script>function echo(){console.log("echo!!!")};</script>',
                                    '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                                  ],
                                ),
                              )),
                        ))
                  ],
                )
              :  SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  const Spacer(flex: 59),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //           icon: const Icon(Icons.arrow_back_ios_outlined),
                  //           //Import any icon, which you want
                  //           color: Colors.black.withOpacity(0.3),
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //           }),
                  //     ],
                  //   ),
                  //   margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  // ),
                  const Spacer(flex: 1),
                  // SvgPicture.string(
                  //   SVGAssets.meetImage,
                  //   width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.fitWidth,
                  // ),
                  const Spacer(flex: 65),
                  Container(
                    child: const Text(
                      "Join the Meet",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  ),
                  const Spacer(flex: 65),
                  Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f3f3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: nameText,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          suffixIcon: const Icon(Icons.person, color: Colors.black),
                          hintText: "Name"),
                    ),
                  ),
                  const Spacer(flex: 58),
                  Container(
                    width: 350,
                    child: const Text(
                      "Meet Guidelines -\n1) For privacy reasons you may change your name if you want.\n2) By default your audio & video are muted.",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff898989),
                      ),
                    ),
                  ),
                  const Spacer(flex: 58),
                  Row(
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
                              borderRadius: BorderRadius.circular(16),
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
                            isVideoMuted = !isVideoMuted!;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: isVideoMuted!
                                  ? const Color(0xffD64467)
                                  : const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(16),
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
                      const Spacer(flex: 16),
                      GestureDetector(
                        onTap: _joinMeeting,
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                color: const Color(0xffAA66CC),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(0, 4)),
                                ]),
                            width: 174,
                            height: 72,
                            child: const Center(
                              child: const Text(
                                "JOIN MEET",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                      const Spacer(flex: 32),
                    ],
                  ),
                  const Spacer(flex: 38),
                ],
              ),
            ),
          ),
          // CallUI(
          //         audiocallback: (val) => setState(() => isAudioMuted = val),
          //         boolCallbackVideo: (val) =>
          //             setState(() => isVideoMuted = val),
          //         joinMeeting: () => _joinMeeting()),
        ),
      ),
    );
  }

  // Widget meetConfig() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 16.0,
  //         ),
  //         TextField(
  //           controller: serverText,
  //           decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: "Server URL",
  //               hintText: "Hint: Leave empty for meet.jitsi.si"),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: roomText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Room",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: subjectText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Subject",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           // controller: nameText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Display Name",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: emailText,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(),
  //             labelText: "Email",
  //           ),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         TextField(
  //           controller: iosAppBarRGBAColor,
  //           decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: "AppBar Color(IOS only)",
  //               hintText: "Hint: This HAS to be in HEX RGBA format"),
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         CheckboxListTile(
  //           title: Text("Audio Only"),
  //           value: isAudioOnly,
  //           onChanged: _onAudioOnlyChanged,
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         CheckboxListTile(
  //           title: Text("Audio Muted"),
  //           value: isAudioMuted,
  //           onChanged: _onAudioMutedChanged,
  //         ),
  //         SizedBox(
  //           height: 14.0,
  //         ),
  //         CheckboxListTile(
  //           title: Text("Video Muted"),
  //           value: isVideoMuted,
  //           onChanged: _onVideoMutedChanged,
  //         ),
  //         Divider(
  //           height: 48.0,
  //           thickness: 2.0,
  //         ),
  //         SizedBox(
  //           height: 64.0,
  //           width: double.maxFinite,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               _joinMeeting();
  //             },
  //             child: Text(
  //               "Join Meeting",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateColor.resolveWith((states) => Colors.blue)),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 48.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.INVITE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText.text)
      ..serverURL = serverUrl
      ..subject = subjectText.text
      ..userDisplayName = nameText.text
      ..userEmail = emailText.text
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..userAvatarURL = "https://pngimg.com/uploads/mario/mario_PNG125.png"
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText.text,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    _showBottomMessageOptions(context);
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }



  void _showBottomMessageOptions(BuildContext context) {
    final items = <Widget>[
        Items(
            StringsEn.edit,
            Icons.edit,
                () => {
                  Navigator.pop(context),
            },
            true),
      Items(
          StringsEn.delete,
          Icons.delete_outline_rounded,
              () => {
            Navigator.pop(context),
          },
          true),
      Items(
          StringsEn.forward,
          Icons.forward_to_inbox_sharp,
              () => {
            Navigator.pop(context),
          },
          false),
    ];

    HelperModels.showActualBottom(items, context);
  }
}
