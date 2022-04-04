import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';

class NoItemWidget extends StatelessWidget {
  final String text;
  final IconData icon;


  const NoItemWidget(this.text, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DelayedDisplay(
      slidingCurve: Curves.ease,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 60,
            color: RingyColors.primaryColor,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: RingyColors.primaryColor,
            ),
          ),
        ],
      ),
    ));
  }
}
