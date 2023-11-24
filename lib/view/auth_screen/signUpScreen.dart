import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/text_style.dart';
import 'package:music_app/controller/auth_controller.dart';
import 'package:music_app/view/home/home.dart';
import 'package:music_app/widget_common/applogo_widget.dart';
import 'package:music_app/widget_common/bg_widget.dart';
import 'package:music_app/widget_common/coustam_textfield.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1)
              .heightBox, //responsive adjust height according to device screen
          applogoWidget(),
          10.heightBox, //this property is replace to SizedBox()
          "Join the $appname".text.fontFamily(bold).white.size(22).make(),
          15.heightBox, //using package:velocity_x
          Obx(() => Column(
                    children: [
                      CoustamTextFiled(
                          title: name,
                          hint: nameHint,
                          controller: nameController,
                          isPass: false),
                      CoustamTextFiled(
                          title: email,
                          hint: emailHint,
                          controller: emailController,
                          isPass: false),
                      CoustamTextFiled(
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          isPass: true),
                      CoustamTextFiled(
                          title: retypePassword,
                          hint: passwordHint,
                          controller: passwordRetypeController,
                          isPass: true),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: forgetPass.text.make(),
                          )),
                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                              checkColor: redColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {});
                                isCheck = newValue;
                                print(isCheck);
                              }),
                          10.heightBox,
                          Expanded(
                              child: RichText(
                                  text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: regular)),
                            TextSpan(
                                text: termAndCondition,
                                style: TextStyle(
                                    color: redColor, fontFamily: regular)),
                            TextSpan(
                                text: "& ",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: regular)),
                            TextSpan(
                                text: termAndCondition,
                                style: TextStyle(
                                    color: fontGrey, fontFamily: regular))
                          ])))
                        ],
                      ),
                      5.heightBox,
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: isCheck == true ? redColor : lightGrey,
                              textColor: whiteColor,
                              onPress: () async {
                                if (isCheck != false) {
                                  controller.isloading(true);
                                  try {
                                    await controller
                                        .signUpMethod(
                                      context: context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    )
                                        .then((value) {
                                      //jo bhi value signUpMethod se return hokar ayegi as a userCredential vo sab then ke inside value me store ho jayegi
                                      return controller.storeUserdata(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        name: nameController.text.trim(),
                                      );
                                    }).then((value) {
                                      VxToast.show(context, msg: loggedIn);
                                      Get.offAll(() => Home());
                                    });
                                  } catch (e) {
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isloading(false);
                                  }
                                }
                              },
                              title: signup,
                            ).box.width(context.screenWidth - 50).make(),
                      //wrapping of Richtext with gesture detector by using velocity-x
                      // RichText(
                      //     text: const TextSpan(children: [
                      //   TextSpan(
                      //       text: alreadyHaveAccount,
                      //       style: TextStyle(color: fontGrey, fontFamily: bold)),
                      //   TextSpan(
                      //       text: login,
                      //       style: TextStyle(color: redColor, fontFamily: bold))
                      // ])).onTap(() {
                      //   Get.back();
                      // }), //like this type wrapped into gesture detector after using velocity-x property,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAccount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          })
                        ],
                      )
                    ],
                  ))
              .box
              .white
              .rounded
              .padding(EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .shadowSm //for shadow
              .make(),
          //here box is replace container
        ]),
      ),
    ));
  }
}
