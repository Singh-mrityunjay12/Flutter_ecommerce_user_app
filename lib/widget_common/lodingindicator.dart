import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/color.dart';

Widget LodingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
