import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/product_controller.dart';
import 'package:music_app/view/chatScreen/chat_screen.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValue();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold1).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  // color: darkFontGrey,
                )),
            Obx(() => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeToWishlist(data.id, context);
                    controller.isFav(false);
                  } else {
                    controller.addToWishlist(data.id, context);
                    controller.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                )))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    //Swiper Section
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction:
                            1.0, //full screen image show karane ke liye
                        itemCount: data['p_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_imgs'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    //title and details section
                    title!.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    //rating
                    VxRating(
                      isSelectable:
                          false, //rating per  click karane per ab koi effect nahi jitana mila hoga utana hi dikhega
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      size: 25,
                      // stepInt: true,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['p_seller']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            5.heightBox,
                            "In House Brands"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            10.heightBox,
                            10.heightBox,
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: lightGrey,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(() => ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(70)
                        .color(textfieldGrey)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .make(),
                    //color section
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color:".text.color(textfieldGrey).make(),
                            ),
                            Obx(
                              () => Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(EdgeInsets.symmetric(
                                                      horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changeColorIndex(index);
                                                print(
                                                    "///////////////////////////////////////");
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ))),
                            )
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                        //quantity row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Quantity:".text.color(textfieldGrey).make(),
                            ),
                            Obx(() => Row(children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                        controller.calculatetotalprice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.remove)),
                                  controller.quantity.value.text
                                      .color(darkFontGrey)
                                      .fontFamily(bold1)
                                      .size(16)
                                      .make(),
                                  IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(int.parse(data[
                                            'p_quantity'])); //here p_quantity is string that'swhy we will use  int.parse(data['p_quantity'])
                                        controller.calculatetotalprice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.add)),
                                  10.widthBox,
                                  "${data['p_quantity']}"
                                      .text
                                      .color(textfieldGrey)
                                      .make()
                                ]))
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),

                        //total row
                        Obx(
                          () => Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total:".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold1)
                                  .size(16)
                                  .make()
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ),
                      ],
                    ).box.color(lightGrey).shadowSm.make(),

                    10.heightBox,
                    //description section
                    "${data['p_desc1']}".text.color(darkFontGrey).make(),

                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    //button section
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        itemDetailButtonList.length,
                        (index) => ListTile(
                          title: "${itemDetailButtonList[index]}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          trailing: Icon(Icons.arrow_forward),
                        )
                            .box
                            .rounded
                            .color(textfieldGrey)
                            .margin(EdgeInsets.symmetric(vertical: 6))
                            .make(),
                      ),
                    ),
                    20.heightBox,
                    //products may like section
                    productsyoumaylike.text
                        .color(darkFontGrey)
                        .fontFamily(bold1)
                        .size(16)
                        .make(),
                    10.heightBox,
                    //i copied this widget from home screen featured product
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgS12,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      10.heightBox,
                                      "Fashion show program"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$400"
                                          .text
                                          .fontFamily(bold1)
                                          .color(redColor)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .margin(
                                          EdgeInsets.symmetric(horizontal: 4))
                                      .padding(EdgeInsets.all(8))
                                      .make()),
                        ))
                  ])),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                        title: data['p_name'],
                        img: data['p_imgs'][0],
                        sellerName: data['p_seller'],
                        color: data['p_colors'][controller.colorIndex.value],
                        quantity: controller.quantity.value,
                        vendorId: data['vendor_id'],
                        totalprice: controller.totalPrice.value,
                        context: context,
                      );
                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context, msg: "Quantity can not be 0");
                    }
                  },
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
