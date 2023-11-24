import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold1).size(18).color(darkFontGrey).make(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator
                      .pop(); //apllication ko totaly close karane ke liye ham use karate h
                },
                textColor: whiteColor,
                title: "yes"),
            10.widthBox,
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
