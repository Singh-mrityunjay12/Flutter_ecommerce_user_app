import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/chat_controller.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/chatScreen/component/sender_bubble.dart';
import 'package:music_app/widget_common/lodingindicator.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("//////////////////////////////////////chat_screen");
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(() => controller.isloading.value
                ? Center(
                    child: LodingIndicator(),
                  )
                : Expanded(
                    child: StreamBuilder(
                        stream: FirestoreServices.getChatMessages(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: LodingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "No Messages  found in messageCollection"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[
                                    index]; //type of object data is  DocumentSnapshot

                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList(),
                            );
                          }
                        }))),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text.trim());
                      //message chale jane ke bad hamlog msgController ko clear kar denge
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 40,
                      color: redColor,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 8))
                .make()
          ],
        ),
      ),
    );
  }
}
