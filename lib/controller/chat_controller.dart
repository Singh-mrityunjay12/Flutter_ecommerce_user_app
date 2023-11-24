import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/controller/homeScreenController.dart';

class ChatController extends GetxController {
  //jaise hi hamara ChatController processes me ayega vaise ham onInit() function ke inside hamlog getChatId(),initialize kar denge

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;
  var isloading = false.obs;

  getChatId() async {
    //jaise hi hamara ye controller me initialized kiya jata h kisi screen per vaise hi hamara ye controller execute hota h aur hamara ye function run karata h
    //jaise hi ye function execute hota h vaise hi isloding true ho jata h aur data get and execute ke bad is loding false ho jati h jisame least time lagata h

    isloading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            //ak bar bat kar chuke hote h
            chatDocId = snapshot.docs.single.id;
          } else {
            //jab pahali bar bat kar rahe ho to to ak document ko create karenge
            chats.add({
              'created_on': null,
              'last_msg': "",
              'users': {friendId: null, currentId: null},
              'toId':
                  "", //isame ham us id store kar rahe jise ham message bhej rahe h
              'fromId':
                  "", //isame ham us id ko store karayege jo user message bhej raha h measn currentUser
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              //jo bhi document create hogi usake doc id ko ham chatDocId me store kara denge
              chatDocId = value.id;
            });
          }
        });
    //data loading ho jane ke bad ham isloading ko false kar dete h
    isloading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId
      });
      //created messages collection inside the chatCollection and store messages
      chats.doc(chatDocId).collection(messageCollection).doc().set({
        //if doc()ke inside me koi id fill nahi karate h to doc() automatic koi random id le lega aur usi id per field create kar dega
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid':
            currentId //is id isliye store kara rahe h taki pata chale message kisane kiya h
      });
    }
  }
}
