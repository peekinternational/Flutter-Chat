import 'dart:io';
import 'package:flutter/material.dart';

class FileImageWidget extends StatelessWidget {
  final String url;
  final IconData failedIcon;
  final Color progressColor;

  const FileImageWidget(
      {Key? key,
      required this.url,
      required this.failedIcon,
      this.progressColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url == ""
        ? const SizedBox()
        : ClipOval(
            child: Image.file(
            File(url),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ));
  }
}
