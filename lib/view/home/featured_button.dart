import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/product_controller.dart';
import 'package:music_app/view/categary_screen/categaryDetail.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featuredButton({String? title, image}) {
  return Row(
    children: [
      Image.asset(
        image,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .roundedSM
      .padding(EdgeInsets.all(4))
      .width(190)
      .height(50)
      .white
      .margin(EdgeInsets.symmetric(horizontal: 8))
      .make()
      .onTap(() {
    var controller = Get.put(ProductController());

    Get.to(() => CategoriesDetail(categorytitle: title));
  });
}
