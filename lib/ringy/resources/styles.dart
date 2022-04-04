import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}