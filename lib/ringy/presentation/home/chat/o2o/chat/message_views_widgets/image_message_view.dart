import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

class ImageMessageView extends StatelessWidget {
  final List<ChatModel> messagesList;
  final int index;

  const ImageMessageView(
      {Key? key, required this.messagesList, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMyMessage = messagesList[index].senderId?.id == Prefs.getString(Prefs.myUserId);

    return messagesList[index].message != null && !messagesList[index].isInProgress!
        ? ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Hero(
            tag: messagesList[index].message!,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                  color: isMyMessage ? RingyColors.lightWhite:RingyColors.primaryColor,
                ),
              ),
              width: 200,
              height: 200,
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
              imageUrl: APIContent.ImageUrl + messagesList[index].message!,
            ),
          ),
        )
        :
    SizedBox(width: 200,height: 200,child: Center(
     child: CircularProgressIndicator(
       color: isMyMessage ? RingyColors.lightWhite:RingyColors.primaryColor,
     ),
   ));
    // Image.asset(
    //         "assets/images/ic_placeholder.png",
    //         fit: BoxFit.cover,
    //       );
  }
}
