import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/model/categories_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var isFav = false.obs;
  //get subcategory from  lib/services/category_model.json file use in itemDetail file
  getSubCategories(title) async {
    subcat
        .clear(); //isase jitane bhi data in subcat me hoga sub clear ho jayenge
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode = categoryModelFromJson(data);
    var s =
        decode.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategories) {
      subcat.add(e);
    }
  }

  //change color according to index use in itemDetail file
  changeColorIndex(index) {
    colorIndex.value = index;
  }

  //increase quantity.value use in itemDetail file
  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  //decrease quantity.value use in itemDetail file
  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

//calculate total price use in itemDetail file
  calculatetotalprice(price) {
    totalPrice.value = price * quantity.value;
  }

  //create method for Add to cart use in itemDetail file
  addToCart(
      {title,
      img,
      sellerName,
      color,
      quantity,
      totalprice,
      context,
      vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellerName': sellerName,
      'color': color,
      'quantity': quantity,
      'vendor_id': vendorId,
      'total_price': totalprice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

//reset old value
  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

//add to wishlist
  addToWishlist(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([
        currentUser!.uid
      ]) //isaka use karake ham inke inside me ham ak list pass karenge
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added into wishlist", bgColor: redColor);
    //SetOptions(merge: true) is function ka use karake letf item ko merge kar lete h jisako ham log update nahi karate h jisase baki field ko override nahi karega
  }

//remove item from wishlist
  removeToWishlist(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([
        currentUser!.uid
      ]) //isaka use karake ham inke inside me ham ak list pass karenge
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist", bgColor: redColor);
    //SetOptions(merge: true) is function ka use karake letf item ko merge kar lete h jisako ham log update nahi karate h jisase baki field ko override nahi karega
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
