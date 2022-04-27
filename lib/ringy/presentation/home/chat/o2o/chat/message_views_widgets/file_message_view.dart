import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

class FileMessageView extends StatelessWidget {
  final List<ChatModel> messagesList;
  final int index;

  const FileMessageView(
      {Key? key, required this.messagesList, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMyMessage = messagesList[index].senderId?.id == Prefs.getString(Prefs.myUserId);
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          InkWell(
              onTap: () => {},
              child: Icon(
                      Icons.folder,
                      size: 30,
                      color: isMyMessage ? RingyColors.lightWhite:RingyColors.primaryColor,
                    )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              messagesList[index].message.toString(),
              maxLines: 1,
              style:  TextStyle(
                  color: isMyMessage ? RingyColors.lightWhite:RingyColors.primaryColor, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
