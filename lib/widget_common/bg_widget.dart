import 'package:flutter/cupertino.dart';
import 'package:music_app/const/images.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.fill)),
    child: child,
  );
}
