import 'package:music_app/const/firebase_const.dart';

class FirestoreServices {
  //get user data
  static getUser(uid) {
    //here we are accessing the data according to user id
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to categories

  static getProduct(category) {
    //here we are accessing the data according to p_category
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get subcategoryProduct
  static getSubCategoryProduct(title) {
    return firestore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  //get cart according to user id
  static getCart(uid) {
    print(uid);
    print(
        "////////////////////////////////////////////////////////////// curentUserId");
    //here we are accessing the data according to user id
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete item
  //delete document
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

//get all chat message according to docId from cloudFirestore
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on',
            descending:
                false) //here descending property isliye use kiya gaya h ki jis order me message send kiya gaya usi order me show karane ke liye
        .snapshots();
  }

  //get All Order
  static getAllOrder() {
    return firestore
        .collection(orderCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get all wishlist
  static getWishlist() {
    return firestore
        .collection(productCollection)
        .where("p_wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  //get all message of user and seller
  static getAllMessage() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where("added_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where("p_wishlist", arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where("order_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  /// how to referece the wishlist
  static allProduct() {
    return firestore.collection(productCollection).snapshots();
  }

  //get featured product
  static getFeaturedProduct() {
    return firestore
        .collection(productCollection)
        .where("is_featured", isEqualTo: true)
        .get(); //ham yadi FutureBuilder()ka use karate h to get() ka use karate h yadi StreamBuilder() ka use karate h data fetch karane ke liye to ham get() and snapshot() dono ka use kar sakate h
  }

  static searchProducts(title) {
    return firestore
        .collection(productCollection)
        // .where('p_name', isLessThanOrEqualTo: title)
        .get();
  }
}
