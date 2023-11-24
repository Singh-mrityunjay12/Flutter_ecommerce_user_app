import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/auth_controller.dart';
import 'package:music_app/controller/profile_Controller.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/auth_screen/loginScreen.dart';
import 'package:music_app/view/chatScreen/mesaging_screen.dart';
import 'package:music_app/view/order_screen/order_screen.dart';
import 'package:music_app/view/profile_Screen/component/detailsCart.dart';
import 'package:music_app/view/profile_Screen/component/edit_profile_screen.dart';
import 'package:music_app/view/wishlist_screen/wishlist_screen.dart';
import 'package:music_app/widget_common/bg_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget_common/lodingindicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor)),
                  );
                } else {
                  var data = snapshot.data!.docs[0];
                  return SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              )).onTap(() {
                            controller.nameController.text = data['name'];
                            // controller.oldpassController.text =
                            //     data['password'];
                            Get.to(() => EditProfileScreen(
                                  data: data,
                                ));
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ""
                                  ? Image.asset(
                                      imgProfile2,
                                      fit: BoxFit.cover,
                                      width: 100,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(
                                      data['imageUrl'],
                                      fit: BoxFit.cover,
                                      width: 100,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  "${data['email']}".text.white.make(),
                                ],
                              )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: whiteColor)),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signOutMethod(context);
                                    Get.offAll(() => LoginScreen());
                                  },
                                  child: logout.text
                                      .fontFamily(semibold)
                                      .white
                                      .make())
                            ],
                          ),
                        ),
                        20.heightBox,
                        FutureBuilder(
                            future: FirestoreServices.getCounts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snashot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: LodingIndicator(),
                                );
                              } else {
                                print("/////////////");
                                print(snapshot.data!.size);
                                print(snapshot.data!.docs.length);

                                print("/////////////");
                                var countData = snapshot.data!.docs;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(
                                      count: countData.length.toString(),
                                      title: "in your cart",
                                      width: context.screenWidth / 3.4,
                                    ),
                                    detailsCard(
                                      count: snapshot.data!.size.toString(),
                                      title: "in your wishlist",
                                      width: context.screenWidth / 3.4,
                                    ),
                                    detailsCard(
                                      count:
                                          snapshot.data!.docs.length.toString(),
                                      title: "your Orders",
                                      width: context.screenWidth / 3.4,
                                    ),
                                  ],
                                );
                              }
                            }),

                        //button section
                        ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(
                                                () => const WishlistScreen());
                                            break;
                                          case 1:
                                            Get.to(() => const OrderScreen());
                                            break;
                                          case 2:
                                            Get.to(() => const MessageScreen());
                                            break;
                                        }
                                      },
                                      leading: Image.asset(
                                        profileButtonIcon[index],
                                        width: 22,
                                      ),
                                      title: profileButtonList[index]
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make());
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemCount: profileButtonList.length)
                            .box
                            .rounded
                            .white
                            .padding(EdgeInsets.symmetric(horizontal: 16))
                            .margin(EdgeInsets.all(12))
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make()
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
