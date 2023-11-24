import 'package:flutter/cupertino.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1".text.fontFamily(semibold).color(redColor).make(),
          ],
        ),
        SizedBox(
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "$title2".text.fontFamily(semibold).make(),
                "$d2".text.make(),
              ],
            ))
      ],
    ),
  );
}
