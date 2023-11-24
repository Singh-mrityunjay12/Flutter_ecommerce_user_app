import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:velocity_x/velocity_x.dart';

Widget CoustamTextFiled({String? hint, String? title, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.fontFamily(semibold).size(16).color(redColor).make(),
      TextFormField(
        controller: controller,
        obscureText: isPass,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontFamily: semibold, color: textfieldGrey),
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox
    ],
  );
}
