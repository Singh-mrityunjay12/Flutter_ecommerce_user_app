import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/string.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //login method
  Future<UserCredential?> loginMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          //jo bhi user login rahega usake sare data ko ham userCredential variable access kar lenge
          email: email,
          password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signUp method ye method tab use karenge jab koi new user ko authentication create karana hoga

  Future<UserCredential?> signUpMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          //jo bhi user login rahega usake sare data ko ham userCredential variable access kar lenge
          email: email,
          password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method into cloud storage
  storeUserdata({name, email, password}) async {
    DocumentReference store =
        await firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': "",
      'id': currentUser!.uid,
      'cart_count': "00",
      'wishlist_count': "00",
      'order_count': "00",
    });
  }

  //signOut method
  signOutMethod(context) {
    try {
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
