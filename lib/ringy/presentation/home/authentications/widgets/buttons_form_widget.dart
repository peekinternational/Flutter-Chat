import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/styles.dart';

class ButtonsFormWidgets extends StatelessWidget {
  final IconData iconData;
  final String textString;
  final VoidCallback onTap;
  final int delay;
  final double width;
  final double height;
  final double gapBetween;

  const ButtonsFormWidgets(
      {Key? key,
      required this.iconData,
      required this.textString,
      required this.onTap,
      this.delay = 0,
      this.width = 200,
      this.height = 50,
      this.gapBetween = 10,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: delay),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: RingyStyles.decor8primaryColor,
          width: width,
          height: height,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: RingyColors.lightWhite,
                ),
                 SizedBox(
                  width: gapBetween,
                ),
                Text(
                  textString,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: RingyColors.lightWhite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
