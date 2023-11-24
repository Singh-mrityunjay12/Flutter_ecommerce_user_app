import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/chatScreen/chat_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget_common/lodingindicator.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessage(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Order yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => ChatScreen(), arguments: [
                                      data[index]['friend_name'],
                                      data[index]['toId']
                                    ]);
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: redColor,
                                    child: Icon(
                                      Icons.person,
                                      color: whiteColor,
                                    ),
                                  ),
                                  title: "${data[index]['friend_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  subtitle: "${data[index]['last_msg']}"
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                              );
                            })),
                  ],
                ),
              );
            }
          }),
    );
  }
}
