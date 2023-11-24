import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/string.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImage = "".obs;
  var profileImagelink = "";
  var isloading = false.obs;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  //changeImage method
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      }
      profileImage.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload profile image into storage

  uploadProfileImage() async {
    var filename = basename(profileImage.value);
    var destination =
        'images/${currentUser!.uid}/$filename'; //path create where image will be stored
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImage.value));
    profileImagelink = await ref.getDownloadURL();
  }

  //update profile or update data

  updateProfileData({name, password, imgUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({
      //set ke inside vahi data write karenge jise upadate karana h
      'name': name,
      'password': password,
      'imageUrl': imgUrl,
    }, SetOptions(merge: true));
    isloading(
        false); //SetOption(merge:true) use karane se ham set vahi data ko wright karenge jise update karana h other ko automatically merge kar dega
  }

  //create new method which i can change  password in Authentication which at login time i can be login with new password
  chageAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      //isaka use karake ham vapas se user ko login karva rahe h aur oldPass ko ham update kar rahe h
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
