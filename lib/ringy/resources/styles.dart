import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors.dart';

class RingyStyles {
  static var decor5white = const BoxDecoration(
    borderRadius:
    BorderRadius.all(Radius.circular(10)),
    color: Colors.white,
    // border: Border.all(color: Colors.black12)
  );

  static var decor8primaryColor =  BoxDecoration(
    borderRadius:
    const BorderRadius.all(Radius.circular(30)),
    color: RingyColors.primaryColor,
    // border: Border.all(color: Colors.black12)
  );


  static var decorChooseCamera = DecoratedBox(
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
            Positioned(
              bottom: 0,
              right: -4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Color(0xFF2626BC),
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
  );
}