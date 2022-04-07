import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/chat/message_views_widgets/file_message_view.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/chat/message_views_widgets/video_message_view.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:velocity_x/velocity_x.dart';

import 'audio_message_view.dart';
import 'image_message_view.dart';
import 'normal_message_view.dart';

class ChatItemDesign extends StatelessWidget {
  final List<ChatModel> messages;
  final int index;
  final TextEditingController _editingController;
  final int isGroup;

  const ChatItemDesign(this.messages, this.index, this._editingController,this.isGroup,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildChatList(context, messages, index, _editingController,isGroup);
  }
}

Widget _buildChatList(BuildContext context, List<ChatModel> messages, int index,
    TextEditingController editingController,int isGroup) {
  var isMyMessage =
      messages[index].senderId?.id == Prefs.getString(Prefs.myUserId);
  var isImageOrVideo = messages[index].messageType == Constants.IMAGE_MSG ||
      messages[index].messageType == Constants.VIDEO_MSG;
  var isAudioOrFile = messages[index].messageType == Constants.AUDIO_MSG ||
      messages[index].messageType == Constants.FILE_MSG;
  var isMessageDeleted = messages[index].isDeleted == 1;
  var isMessageInProgress = messages[index].isInProgress;
  var isMessageSeen = messages[index].isSeen == 1;
  var showGroupUserName = !isMyMessage && isGroup == 1;
  return Container(
    padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
    child: Align(
      alignment: (!isMyMessage ? Alignment.topLeft : Alignment.topRight),
      child: Padding(
        padding: isMyMessage
            ? const EdgeInsets.only(left: 40)
            : const EdgeInsets.only(right: 40),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: !isMyMessage
                  ? const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                  : const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
              color: (!isMyMessage
                  ? Colors.grey.shade200
                  : RingyColors.primaryColor),
            ),
            padding: EdgeInsets.all(isImageOrVideo
                ? 8
                : isAudioOrFile
                    ? 8
                    : 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: isMyMessage? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                showGroupUserName ?  Text("Sender Name",style: TextStyle(color: Vx.randomPrimaryColor,fontWeight: FontWeight.w600),):const SizedBox(),
                SizedBox(
                  height: showGroupUserName ? 6: 0,
                ),
                isMessageDeleted
                    ? NormalMessageView(
                        messagesList: messages,
                        index: index,
                      )
                    : messages[index].messageType == Constants.VIDEO_MSG
                        ? VideoMessageView(messagesList: messages, index: index)
                        : messages[index].messageType == Constants.IMAGE_MSG
                            ? ImageMessageView(
                                messagesList: messages, index: index)
                            : messages[index].messageType == Constants.AUDIO_MSG
                                ? AudioMessageView(
                                    messagesList: messages, index: index)
                                : messages[index].messageType ==
                                        Constants.FILE_MSG
                                    ? FileMessageView(
                                        messagesList: messages,
                                        index: index,
                                      )
                                    : NormalMessageView(
                                        messagesList: messages,
                                        index: index,
                                      ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      HelperClass.getFormatedDate(
                          messages[index].createdAt ?? ""),
                      style: TextStyle(
                          color: isMyMessage
                              ? RingyColors.tickColorSender
                              : RingyColors.tickColorReceiver),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (isMyMessage)
                      isMessageInProgress!
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: isMyMessage
                                    ? RingyColors.lightWhite
                                    : RingyColors.primaryColor,
                                strokeWidth: 1.5,
                              ),
                            )
                          : Icon(
                              Icons.check,
                              size: 16,
                              color: isMessageSeen
                                  ? RingyColors.blueTick
                                  : RingyColors.tickColorSender,
                            ),
                  ],
                )
              ],
            )),
      ),
    ),
  );
}
