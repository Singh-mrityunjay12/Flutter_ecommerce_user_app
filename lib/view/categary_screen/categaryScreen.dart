import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/product_controller.dart';
import 'package:music_app/view/categary_screen/categaryDetail.dart';
import 'package:music_app/widget_common/bg_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.white.fontFamily(bold1).make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImageList[index],
                    width: 200,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoriesList[index]
                      .text
                      .align(TextAlign.center)
                      .color(darkFontGrey)
                      .make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);

                Get.to(() =>
                    CategoriesDetail(categorytitle: categoriesList[index]));
              });
            }),
      ),
    ));
  }
}
