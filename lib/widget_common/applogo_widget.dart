import 'package:flutter/cupertino.dart';
import 'package:music_app/const/images.dart';
import 'package:velocity_x/velocity_x.dart';

Widget applogoWidget() {
  //using velocity-x here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(EdgeInsets.all(10))
      .rounded
      .make();
}
