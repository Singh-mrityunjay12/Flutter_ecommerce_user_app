import 'package:flutter/cupertino.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:velocity_x/velocity_x.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold1).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.padding(EdgeInsets.all(4)).width(width).height(75).make();
}
