import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

class Items extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback function;
  final bool showBottomLine;


  const Items(this.text, this.icon, this.function,this.showBottomLine, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DelayedDisplay(
          child: ListTile(
            dense: true,
            leading: Icon(icon),
            title: Text(text),
            onTap: function,
          ),
        ),
       if(showBottomLine) const Divider(
          height: 1,
        ),
      ],
    );
  }
}
