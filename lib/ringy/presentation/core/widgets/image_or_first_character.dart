import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';

import '../../../infrastructure/API/api_content.dart';

class ImageOrFirstCharacter extends StatelessWidget {
  final int radius;
  final String imageUrl;
  final String name;
  final bool isLock;
  final bool isPublic;

  const ImageOrFirstCharacter({
    Key? key,
    this.radius = 22,
    required this.imageUrl,
    required this.name,
    this.isLock = false,
    this.isPublic = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + 1,
      backgroundColor: RingyColors.primaryColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: RingyColors.lightWhite,
            child: imageUrl == ""
                ? name == ""
                    ? const Text("")
                    : Center(
                        child: Text(
                          getFirstTwoCharOfUserName(name),
                          style: TextStyle(
                              color: RingyColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                : ClipOval(
                    child: Image.network(
                      APIContent.ImageUrl + imageUrl,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
            radius: 25,
          ),
          if (isPublic)
            Padding(
              padding: const EdgeInsets.all(0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: RingyColors.lightWhite,
                      radius: 9,
                      child: Icon(Icons.ac_unit_rounded,
                          size: 14, color: RingyColors.primaryColor))),
            ),
          if (isLock)
            Padding(
              padding: const EdgeInsets.all(0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                      backgroundColor: RingyColors.lightWhite,
                      radius: 9,
                      child: Icon(
                        Icons.lock_open,
                        size: 14,
                        color: RingyColors.blue,
                      ))),
            )
        ],
      ),
    );
  }

  String getFirstTwoCharOfUserName(String s1) {
    String finalStr = "";
    String lastStr = "";
    String firstStr = "";
    List myName;
    try {
      if (s1 != null) {
        myName = s1.trim().split(" ");
        if (myName.length > 1) {
          String s = myName[myName.length - 1].trim();
          lastStr = s[0];

          String f2 = myName[0].trim();
          firstStr = f2[0];

          finalStr = firstStr.toUpperCase() + lastStr.toUpperCase();
        } else {
          finalStr = s1[0].toUpperCase();
        }
      }
    } catch (e) {
      finalStr = s1;
    }

    return finalStr;
  }
}
