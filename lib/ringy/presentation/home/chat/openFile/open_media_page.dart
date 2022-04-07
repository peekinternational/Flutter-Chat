import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/openFile/video_player.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';


class OpenMediaPage extends StatelessWidget {
  final bool isVideo;
  final String url;

  const OpenMediaPage(this.isVideo, this.url, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RingyColors.lightWhite,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: RingyColors.lightWhite,
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: isVideo ? VideoPlayerScreen(url) : _buildImage(url, context),
    );
  }

}

Widget _buildImage(String url, BuildContext context) {
  return Center(
    child: Hero(
      tag: url,
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            value: progress.progress,
            color: RingyColors.primaryColor,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        filterQuality: FilterQuality.low,
        fit: BoxFit.cover,
        imageUrl: APIContent.imageURl + url,
      ),
    ),
  );
}
