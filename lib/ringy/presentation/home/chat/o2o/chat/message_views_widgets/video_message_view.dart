import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

class VideoMessageView extends StatelessWidget {
  final List<ChatModel> messagesList;
  final int index;

  const VideoMessageView(
      {Key? key, required this.messagesList, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMyMessage = messagesList[index].senderId?.id == Prefs.getString(Prefs.myUserId);
    return SizedBox(
      width: 200,
      height: 200,
      child: Padding(
        padding:
            messagesList[index].senderId?.id == Prefs.getString(Prefs.myUserId)
                ? const EdgeInsets.only(left: 5)
                : const EdgeInsets.only(right: 5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/ic_placeholder.png",
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
            Center(
              child: messagesList[index].isInProgress!
                  ?  CircularProgressIndicator(
                      color: isMyMessage ? RingyColors.lightWhite:RingyColors.primaryColor,
                    )
                  : const Icon(
                      Icons.play_circle_filled_outlined,
                      size: 50,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
