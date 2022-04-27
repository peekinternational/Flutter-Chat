import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
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
