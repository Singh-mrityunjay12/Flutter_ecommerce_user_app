import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/controller/homeScreenController.dart';
import 'package:velocity_x/velocity_x.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  // @override
  // void onInit() {
  //   getProductDetail();
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  //text controllers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0
      .obs; //isase ham usi payment option ke border aur checkbox show jo click hoga

  late dynamic productSnapshot;
  var productDetail = [];

  var placingMYOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value =
          totalP.value + int.parse(data[i]['total_price'].toString());
    }
  }

//change paymentIndex
  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

//place my order
  placeMyOrder(
      {required orderPaymentMethod, required totalAmount, context}) async {
    placingMYOrder(true);
    await getProductDetail();
    await firestore.collection(orderCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text.trim(),
      'order_by_city': cityController.text.trim(),
      'order_by_state': stateController.text.trim(),
      'order_by_phone': phoneController.text.trim(),
      'order_by_postalcode': postalCodeController.text.trim(),
      'sipping_method': "Home Delivery",
      "payment_Method": orderPaymentMethod,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivered': false,
      'order_place': true,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(
          productDetail), //array or list ko add karane ka method h
    });
    placingMYOrder(false);
    // VxToast.show(context, msg: "Add order collection in cloudStorage");
  }

  getProductDetail() {
    productDetail.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      // here productSnapshot.length will be three.

      productDetail.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'quantity': productSnapshot[i]['quantity'],
        'vendorId': productSnapshot[i]['vendor_id'],
        'total_price': productSnapshot[i]['total_price'],
        'title': productSnapshot[i]['title']
      });
    }

    print("///////////////////////////////////////////////////dfgh");
    print(productDetail);
    print("/////////////////////////////////////////////////");
  }

  //cart ke item ko place in order karane ke bad or add karene ke bad cart ke item ko clear kar denge kyoki ham use ak bar add kar chuke h or place in order
  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
