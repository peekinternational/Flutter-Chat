import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen(this.url, {Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(url);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String url;
  static const platform =
      MethodChannel('com.ringy.ringychat.ringy_flutter/ssl_trust_manager');

  _VideoPlayerScreenState(this.url);

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      if (Platform.isAndroid) {
            _grantTrustManager();
          }
    }
    _controller = VideoPlayerController.network(
      APIContent.imageURl + url,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: SizedBox(
                width:double.infinity,
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller)),
              ),
            );
          } else {
            return  Center(
              child: CircularProgressIndicator(color: RingyColors.primaryColor,),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: RingyColors.primaryColor,
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  Future<void> _grantTrustManager() async {
    try {
      final int result = await platform.invokeMethod('grantTrustManager');
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
