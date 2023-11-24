import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_app/const/firebase_const.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  //jab bhi HomeController ko start karenge to onInit function ko call kar lunga
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserName();
  }

  var searchController = TextEditingController();

  var username = '';
  getUserName() async {
    var n = await firestore
        .collection(userCollection)
        .where('id',
            isEqualTo: currentUser!
                .uid) //after  get() function use karane  bad jo bhi document ke data ayega  vo sab value a store ho jati h
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single[
            'name']; //jo bhi yaha se name return hoga vo jaker n me save ho jayega
      }
    });
    username = n;
    print("///////////////////////////////////////HomeController");
    print(n);
  }
}
