import 'package:flutter/cupertino.dart';
import 'package:music_app/const/color.dart';

const bold = "bold";
const regular = "regular";
//method 1 reusable Text
ourStyle({family = "regular", double? size = 18, color = whiteColor}) {
  return TextStyle(fontFamily: family, fontSize: size, color: color);
}
