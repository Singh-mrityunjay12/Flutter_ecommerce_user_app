import 'package:flutter/cupertino.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:velocity_x/velocity_x.dart';

Widget HomeButton({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .rounded
      .white
      .size(width, height)
      // .shadowXs use for shadow
      .make(); //container is replace by box
}
