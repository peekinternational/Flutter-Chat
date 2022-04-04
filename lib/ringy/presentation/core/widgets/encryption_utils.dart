import 'package:encrypt/encrypt.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';

class EncryptData{
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;


  static String encryptAES(String mMessage, String? aesKey){

    if (Constants.isEncrypted) {
      try {
            final iv1 = aesKey?.substring(0, 16);

            final key = Key.fromUtf8(aesKey!);
            final iv = IV.fromUtf8(iv1!);
            final aesEncrypter = Encrypter(AES(key, mode: AESMode.cbc));

            final encrypted = aesEncrypter.encrypt(mMessage, iv: iv);
            return encrypted.base64;
          }on Exception catch (e) {
            return mMessage;
          }
    } else {
      return mMessage;
    }
  }


  static String decryptAES(String encryptedMessage, String? s) {
    if (Constants.isEncrypted) {
      try {
            try {
                  final iv1 = s?.substring(0, 16);
                  final key = Key.fromUtf8(s!);
                  final iv = IV.fromUtf8(iv1!);
                  final encrypter = Encrypter(AES(key,mode:AESMode.cbc));
                  final data = encrypter.decrypt64(encryptedMessage, iv: iv);
                  return data;
                } on Exception catch (e) {
                  return encryptedMessage;
                }
          } catch (e) {
            return encryptedMessage;
          }
    } else {
      return encryptedMessage;
    }
  }
}