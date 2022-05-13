

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/message_enum.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:path_provider/path_provider.dart';

class HelperClass {
  static String getFormatedDate(_date) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      // String dateWithT = _date.substring(0, 11) + 'T' + _date.substring(11);
      var inputDate = inputFormat.parse(_date);
      var outputFormat = DateFormat('M/d EEE');
      return outputFormat.format(inputDate);
    } catch (e) {
      print(e);
      return "";
    }
  }

  static String getFormatedDateWithT(_date) {
    var inputFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
    // String dateWithT = _date.substring(0, 11) + 'T' + _date.substring(11);
    var inputDate = inputFormat.parse(_date);
    // var outputFormat = DateFormat('M/d EEE');
    return inputDate.toString();
  }

  static Whom isMessageForMe(String receiverId, String senderId, String openedChatUserId) {
    if (receiverId == Prefs.getString(Prefs.myUserId) ||
        senderId == Prefs.getString(Prefs.myUserId)) {
      if(senderId == Prefs.getString(Prefs.myUserId) && receiverId != openedChatUserId){
        return Whom.iAmForwarded;
      }
      if (senderId == Prefs.getString(Prefs.myUserId)) {
        return Whom.iAmSender;
      } else {
        return Whom.iAmReceiver;
      }
    }
    return Whom.notForMe;
  }

  static String checkLastMessage(
      String message, int? messageType, latestMsgSenderId) {
    return message == ""
        ? StringsEn.noChatFound
        : messageType == Constants.normalMSG
            ? EncryptData.decryptAES(message, latestMsgSenderId)
            : messageType == Constants.imageMSG
                ? StringsEn.image
                : messageType == Constants.videoMSG
                    ? StringsEn.video
                    : messageType == Constants.fileMSG
                        ? StringsEn.file
                        : messageType == Constants.audioMSG
                            ? StringsEn.audio
                            : messageType == Constants.locationMSG
                                ? StringsEn.location
                                : "";
  }

  static Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/"file"/$uniqueFileName';

    return path;
  }
  static double getPercentage()  {

    double percentage = 0.0;
    if(Prefs.getString(Prefs.myImage) != ""){
      percentage += 0.25;
    }
    if(Prefs.getString(Prefs.myName) != ""){
      percentage += 0.25;
    }
    if(Prefs.getString(Prefs.myMail) != ""){
      percentage += 0.25;
    }
    if(Prefs.getString(Prefs.myUserId) != ""){
      percentage += 0.25;
    }

    return percentage;
  }


  static String constructFCMPayload(List<String?>? token, String title,String body) {
    var res = jsonEncode({
      // 'token': token,
      'notification': {
        "title": title,
        "body" : body
      },
      "priority": "high",
      'data': {
        "message": " data message",
      },
      'registration_ids':token,
      // 'to': token,
    });

    print(res.toString());
    return res;
  }

  static Future<String?> getFcmToken() async {
    var res = await FirebaseMessaging.instance.getToken();
    return res;
  }
}
