import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../../core/socket/users_socket_utils.dart';
import '../../core/utils/helper_models.dart';
import '../../core/utils/socket_helper.dart';

class JoinCall implements SocketEventsCall {
  late void Function(dynamic ss) callPickingStatusHandler;
  late void Function(dynamic ss) callTerminatedStatusHandler;
  final _socketProvider = SocketProviderUsers();
  bool amISender = false;

  initMeeting(Function(dynamic ss) pickingCallback,
      Function(dynamic ss) terminateCallback, bool amISender) {
    amISender = amISender;
    callPickingStatusHandler = pickingCallback;
    callTerminatedStatusHandler = terminateCallback;
    setupSocket();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  removeListeners() {
    JitsiMeet.closeMeeting();
    JitsiMeet.removeAllListeners();
  }
  void closeCall(){
    JitsiMeet.closeMeeting();
  }

  void setupSocket() {
    _socketProvider.setEventListenerCall(this);
    _socketProvider.getSocket();
    _socketProvider.mSocketOn(SocketHelper.onCallAccepted);
  }

  callAcceptedStatusFromReceiver(
    String id,
    String status,
    bool isGroup,
  ) {
    _socketProvider.mSocketEmit(SocketHelper.emitCallAccepted,
        HelperModels.getCallStatusForSocket(id, status, amISender, isGroup));
  }

  joinMeeting(
    String serverText,
    String roomText,
    String subjectText,
    String nameText,
    var isAudioOnly,
    var isAudioMuted,
    var isVideoMuted,
  ) async {
    String? serverURL = serverText.trim().isEmpty ? null : serverText;
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
    var options = JitsiMeetingOptions(room: roomText)
      ..serverURL = serverURL
      ..subject = subjectText
      ..userDisplayName = nameText
      // ..userEmail = emailText
      // ..iosAppBarRGBAColor = iosAppBarRGBAColor
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..userAvatarURL = "https://pngimg.com/uploads/mario/mario_PNG125.png"
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText}
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
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    _socketProvider.mSocketEmit(
        SocketHelper.emitCallAccepted,
        HelperModels.getCallStatusForSocket(
            Prefs.getString(Prefs.myUserId)!, "0", amISender, false));
    callTerminatedStatusHandler.call(true);
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  void eventListener(String eventName, Object args) {
    if (eventName == SocketHelper.onCallAccepted) {
      print("objectSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS> $args");
      callPickingStatusHandler.call(args);
      // getCallData(args, context);
    }
  }
}
