import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'file_Image_widget.dart';

class ChooseFileImage extends StatelessWidget {
  final String iconPath;
  final bool isFile;

  const ChooseFileImage({Key? key, required this.iconPath, this.isFile = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: RingyColors.primaryColor, width: .5),
              shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              radius: 36,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                      child: isFile
                          ? FileImageWidget(
                              url: iconPath, failedIcon: Icons.error)
                          : CachedNetworkImage(
                              imageUrl: APIContent.imageURl + iconPath)),
                  Positioned(
                    bottom: 0,
                    right: -4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: RingyColors.darkBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.camera,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
