import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/cartController.dart';
import 'package:music_app/view/home/home.dart';
import 'package:music_app/widget_common/lodingindicator.dart';

import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<
        CartController>(); //CartController Already initialized before screen that'sWhy here i sm using Get.find<CartController>()

    // var controller = Get.put(CartController());
    print("Payment Method Screen");
    return Obx(() => Scaffold(
          backgroundColor: whiteColor,
          bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingMYOrder.value
                ? Center(
                    child: LodingIndicator(),
                  )
                : ourButton(
                    color: redColor,
                    textColor: whiteColor,
                    onPress: () async {
                      await controller.placeMyOrder(
                          orderPaymentMethod:
                              paymentMethod[controller.paymentIndex.value],
                          totalAmount: controller.totalP.value,
                          context: context);
                      await controller.clearCart();
                      VxToast.show(context, msg: "Order placed Successfuly");
                      Get.offAll(() => const Home());
                    },
                    title: "Place my order"),
          ),
          appBar: AppBar(
            title: "Choose Payment meythod"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(paymentMethodListImg.length, (index) {
                return Obx(() => GestureDetector(
                      onTap: () {
                        controller.changePaymentIndex(index);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              // style: BorderStyle.solid,
                              color: controller.paymentIndex.value == index
                                  ? redColor
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment
                                .topRight, //ye use nhi kara te yo ham position widget se wrape kar dete TransForm.scale ko
                            children: [
                              Image.asset(
                                paymentMethodListImg[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                colorBlendMode:
                                    controller.paymentIndex.value == index
                                        ? BlendMode.darken
                                        : BlendMode.color,
                                color: controller.paymentIndex.value == index
                                    ? Colors.black.withOpacity(0.4)
                                    : Colors.transparent,
                                height: 100,
                              ),
                              controller.paymentIndex.value == index
                                  ? Transform.scale(
                                      //Transform.scale ka use ham Checkbox ki size increase karane ke liye karate h
                                      scale: 1.3,
                                      child: Checkbox(
                                          activeColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          value: true,
                                          onChanged: (value) {}))
                                  : Container(),
                              Positioned(
                                  //stack me align karane ke liye ham log Positioned() widget ka use karate h
                                  bottom: 10,
                                  right: 10,
                                  child: paymentMethod[index]
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make())
                            ],
                          ),
                        ),
                      ),
                    ));
              }),
            ),
          ),
        ));
  }
}
