import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/cartController.dart';
import 'package:music_app/view/cart_Screen/payment_method.dart';
import 'package:music_app/widget_common/coustam_textfield.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(CartController());
    //Or
    var controller = Get.find<CartController>();
    print("Shipping Screen");
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            color: redColor,
            onPress: () {
              if (controller.addressController.text.trim().length > 10) {
                Get.to(() => const PaymentMethod());
              } else {
                VxToast.show(context, msg: "PLease Fill the form");
              }
            },
            textColor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CoustamTextFiled(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController),
          CoustamTextFiled(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController),
          CoustamTextFiled(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController),
          CoustamTextFiled(
              hint: "Postal Code",
              isPass: false,
              title: "Postal Code",
              controller: controller.postalCodeController),
          CoustamTextFiled(
              hint: "Phone",
              isPass: false,
              title: "Phone",
              controller: controller.phoneController)
        ]),
      ),
    );
  }
}
