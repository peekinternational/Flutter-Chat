import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'file_Image_widget.dart';

class ChooseFileImageWithPercentage extends StatelessWidget {
  final String iconPath;
  final bool isFile;
  final double percentage;

  const ChooseFileImageWithPercentage(
      {Key? key,
      required this.iconPath,
      this.isFile = true,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: CircularPercentIndicator(
          radius: 44,
          progressColor: RingyColors.primaryColor,
          lineWidth: 4,
          startAngle: 0,
          percent: percentage,
          animation: true,
          animationDuration: 1000,
          backgroundColor: Colors.transparent,
          center: Padding(
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
                          : ClipOval(
                            child: CachedNetworkImage(
                                errorWidget: (context, url, error) {
                                  return Center(child: Container());
                                },
                                height: double.infinity,
                                width: double.infinity,
                            fit: BoxFit.cover,
                                imageUrl: APIContent.imageURl + iconPath),
                          )),
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
