import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl; //this package use for time

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  //DateFormate
  var time = intl.DateFormat("h:mma").format(t);
  return data['uid'] == currentUser!.uid
      ? SingleChildScrollView(
          child: Directionality(
              textDirection: data['uid'] == currentUser!.uid
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${data['msg']}".text.white.make(),
                    10.heightBox,
                    time.text.color(whiteColor.withOpacity(0.5)).make()
                  ],
                ),
              )))
      : SingleChildScrollView(
          child: Directionality(
              textDirection: data['uid'] == currentUser!.uid
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                    color: darkFontGrey,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    "${data['msg']}".text.white.make(),
                    10.heightBox,
                    time.text.color(whiteColor.withOpacity(0.5)).make()
                  ],
                ),
              )));
}
