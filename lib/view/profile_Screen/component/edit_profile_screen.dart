import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/controller/profile_Controller.dart';
import 'package:music_app/widget_common/bg_widget.dart';
import 'package:music_app/widget_common/coustam_textfield.dart';
import 'package:music_app/widget_common/our_Button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(() => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //if data image and profileImage is empty
                    data['imageUrl'] == '' &&
                            controller.profileImage.value.isEmpty
                        ? Image.asset(
                            imgProfile2,
                            fit: BoxFit.cover,
                            width: 100,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        //if data image is not empty but profileImage is empty
                        : data['imageUrl'] != '' &&
                                controller.profileImage.value.isEmpty
                            ? Image.network(
                                data['imageUrl'],
                                fit: BoxFit.cover,
                                width: 100,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            //Both are empty
                            : Image.file(
                                File(controller.profileImage.value),
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.heightBox,
                    ourButton(
                        color: redColor,
                        onPress: () {
                          Get.find<ProfileController>().changeImage(
                              context); //ProfileController ko ham initialized kar diye ham profileScreen me ise ham find function ke help se use kar skate h
                          //Or
                          // controller.changeImage(context);
                        },
                        textColor: whiteColor,
                        title: "Change"),
                    Divider(),
                    20.heightBox,
                    CoustamTextFiled(
                        hint: "nameHint",
                        isPass: false,
                        title: "Name",
                        controller: controller.nameController),
                    CoustamTextFiled(
                        hint: "passwordHint",
                        isPass: true,
                        title: oldpass,
                        controller: controller.oldpassController),
                    CoustamTextFiled(
                        hint: "passwordHint",
                        isPass: true,
                        title: newPass,
                        controller: controller.newpassController),
                    20.heightBox,
                    controller.isloading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : SizedBox(
                            width: context.screenWidth - 60,
                            child: ourButton(
                                color: redColor,
                                onPress: () {
                                  controller.isloading(true);

                                  //if image is selected by user or change profile image
                                  if (controller.profileImage.value
                                      .isNotEmpty) //means image is picked
                                  {
                                    controller.uploadProfileImage();
                                  } else {
                                    //yadi user image ko bina picked kiye hi upadate karana chaye tab ke liye
                                    controller.profileImagelink = data[
                                        'imageUrl']; //jisase profileImagelink empty na ho sake
                                  }

                                  //if old password matches data pass then we can upadate profileData
                                  if (data['password'] ==
                                      controller.oldpassController.text
                                          .trim()) {
                                    //change password in Authentication
                                    controller.chageAuthPassword(
                                      email: currentUser!
                                          .email, // Or email:data['email']
                                      password: controller
                                          .oldpassController.text
                                          .trim(),
                                      newPassword: controller
                                          .newpassController.text
                                          .trim(),
                                    );

                                    controller.updateProfileData(
                                        name: controller.nameController.text
                                            .trim(),
                                        password: controller
                                            .newpassController.text
                                            .trim(),
                                        imgUrl: controller.profileImagelink);
                                    VxToast.show(context, msg: "updated");
                                  } else {
                                    VxToast.show(context,
                                        msg:
                                            "Old password is not matches with data base password");
                                    controller.isloading(
                                        false); //jisase hamara save vale button phir se show ho jaye
                                  }
                                },
                                textColor: whiteColor,
                                title: "Save"),
                          ),
                  ],
                ),
              ))
          .box
          .white
          .shadowSm
          .padding(EdgeInsets.all(16))
          .margin(EdgeInsets.only(top: 40, left: 12, right: 12))
          .rounded
          .make(),
    ));
  }
}
