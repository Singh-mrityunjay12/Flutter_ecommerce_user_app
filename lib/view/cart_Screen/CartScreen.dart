import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/cartController.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/cart_Screen/shiping_screen.dart';
import 'package:music_app/widget_common/lodingindicator.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          // width: context.screenWidth - 60,
          child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => const ShippingScreen());
              },
              textColor: whiteColor,
              title: "Proceed to shipping"),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false, //remove the arrow sign
          elevation: 0,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: LodingIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics:  const NeverScrollableScrollPhysics(),

                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                    "${data[index]['img']}",
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']} (x${data[index]['quantity']})"
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                  subtitle: "${data[index]['total_price']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                    //here data[index].id ye field id nahi h ye document id h field id means currentUser!.uid fild id database me store rahata h aur database jis id per store hota h use docId kahate h
                                    print(
                                        "///////////////////////////////////////");
                                    print(data[index].id);
                                    print(
                                        "///////////////////////////////////////");
                                  }),
                                );
                              }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          Obx(() => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make()),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //   width: context.screenWidth - 60,
                      //   child: ourButton(
                      //       color: redColor,
                      //       onPress: () {},
                      //       textColor: whiteColor,
                      //       title: "Proceed to shipping"),
                      // )
                    ],
                  ),
                );
              }
            }));
  }
}
