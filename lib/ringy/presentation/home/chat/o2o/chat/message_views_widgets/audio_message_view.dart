import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

class AudioMessageView extends StatelessWidget {
  final List<ChatModel> messagesList;
  final int index;

  AudioMessageView({Key? key, required this.messagesList, required this.index})
      : super(key: key);

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var isMyMessage = messagesList[index].senderId?.id == Prefs.getString(Prefs.myUserId);
    final durationState = audioPlayer.state;
    // final progress = durationState?.progress ?? Duration.zero;
    // final buffered = durationState?.buffered ?? Duration.zero;
    // final total = durationState?.total ?? Duration.zero;
    return SizedBox(
      width: 250,
      child: Row(
        children: [
          InkWell(
              onTap: () => {audioPlayer.play(messagesList[index].message!)},
              child: Icon(
                Icons.play_circle_outline,
                size: 30,
                color: isMyMessage ? RingyColors.lightWhite : Colors.black,
              )),
          Expanded(
            child: Slider(
              onChanged: (double value) {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              },
              value: 0,
              thumbColor: isMyMessage ? RingyColors.lightWhite : Colors.black,
              inactiveColor: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
