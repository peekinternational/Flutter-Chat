import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

class NormalMessageView extends StatelessWidget {
  final List<ChatModel> messagesList;
  final int index;

  const NormalMessageView({
    Key? key,
    required this.messagesList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMyMessage =
        messagesList[index].senderId?.id == Prefs.getString(Prefs.myUserId);
    var isMessageDeleted = messagesList[index].isDeleted == 1;
    return
      // Row(
      // mainAxisSize: MainAxisSize.min,
      // // verticalDirection: VerticalDirection.down,
      // children: [
      //      if(messagesList[index].isInProgress!)   SizedBox(
      //     width: 18,
      //     height: 18,
      //     child: CircularProgressIndicator(
      //       color: isMyMessage ? RingyColors.lightWhite:RingyColors.primaryColor,
      //       strokeWidth: 2,
      //     ),
      //   ),
      //   if(messagesList[index].isInProgress!) const SizedBox(width: 8,),
        Flexible(
          child: Text(
            isMessageDeleted ? StringsEn.deleted: EncryptData.decryptAES(messagesList[index].message.toString(),
                messagesList[index].senderId?.id),

            style: TextStyle(
              fontSize: 15,
              color: isMyMessage ? Colors.white : Colors.black,
              fontStyle: isMessageDeleted ? FontStyle.italic : FontStyle.normal,
              fontWeight: isMessageDeleted ? FontWeight.w300 : FontWeight.normal,
              letterSpacing: isMessageDeleted ? 2 :0
            ),
          ),
        // ),
    //   ],
    );
  }
}
