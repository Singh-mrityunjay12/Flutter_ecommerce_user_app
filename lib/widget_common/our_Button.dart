import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/text_style.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({color, textColor, onPress, String? title}) {
  return ElevatedButton(
      style:
          ElevatedButton.styleFrom(primary: color, padding: EdgeInsets.all(12)),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
