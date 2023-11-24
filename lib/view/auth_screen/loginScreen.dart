import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/const/text_style.dart';
import 'package:music_app/controller/auth_controller.dart';
import 'package:music_app/view/auth_screen/signUpScreen.dart';
import 'package:music_app/view/home/home.dart';
import 'package:music_app/widget_common/applogo_widget.dart';
import 'package:music_app/widget_common/bg_widget.dart';
import 'package:music_app/widget_common/coustam_textfield.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
          "Log in to $appname".text.fontFamily(bold).white.size(22).make(),
          15.heightBox, //using package:velocity_x
          Obx(() => Column(
                    children: [
                      CoustamTextFiled(
                          title: email,
                          hint: emailHint,
                          isPass: false,
                          controller: emailController),
                      CoustamTextFiled(
                          title: password,
                          hint: passwordHint,
                          isPass: true,
                          controller: passwordController),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: forgetPass.text.make(),
                          )),
                      5.heightBox,
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: redColor,
                              textColor: whiteColor,
                              onPress: () async {
                                controller.isloading(true);
                                await controller
                                    .loginMethod(
                                        context: context,
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim())
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => Home());
                                  } else {
                                    controller.isloading(false);
                                  }
                                });
                              },
                              title: login,
                            ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(
                        color: lightGolden,
                        textColor: redColor,
                        onPress: () {
                          Get.to(() => SignUpScreen());
                        },
                        title: signup,
                      ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      loginwith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            socialIcon.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      socialIcon[index],
                                      width: 30,
                                    ),
                                  ),
                                )),
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
