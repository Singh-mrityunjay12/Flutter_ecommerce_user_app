import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/const/text_style.dart';
import 'package:music_app/controller/product_controller.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/categary_screen/itemDetail.dart';
import 'package:music_app/widget_common/bg_widget.dart';
import 'package:music_app/widget_common/lodingindicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesDetail extends StatefulWidget {
  final String? categorytitle;
  CategoriesDetail({Key? key, required this.categorytitle}) : super(key: key);

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  var controller = Get.find<
      ProductController>(); //pahale hamane initilise kara liye isiliye yaha kaval find kar rahe h controller ko
  dynamic productMethod;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.categorytitle);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      //here subcat is a list which i did to create in product_controller
      productMethod = FirestoreServices.getSubCategoryProduct(title);
    } else {
      productMethod = FirestoreServices.getProduct(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(controller.subcat.length);
    print("/////////////////////////////////////////categaryDetail");
    print(Colors.amber.value);
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.categorytitle!.text.fontFamily(bold).white.make(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => controller.subcat[index]
                                  .toString()
                                  // Or "${controller.subcat[index]}"
                                  .text
                                  .align(TextAlign.center)
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .makeCentered()
                                  .box
                                  .size(130, 60)
                                  .roundedSM
                                  .white
                                  .margin(EdgeInsets.symmetric(horizontal: 8))
                                  .make()
                                  .onTap(() {
                                switchCategory(
                                    controller.subcat[index].toString());
                                setState(() {});
                              })),
                    )),
                20.heightBox,
                StreamBuilder(
                    //real changes show by StreamBuilder to access the data from firebase
                    stream: productMethod,
                    // FirestoreServices.getProduct(widget.categorytitle),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        //means snapshot is empty
                        return Expanded(
                          child: Center(
                            child: LodingIndicator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No Product Found in FirestoreFirebase"
                              .text
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      } else {
                        //product is present in the FirestoreFirebase means snapshot.data!.docs.isNotEmpty
                        var data = snapshot.data!.docs;
                        return Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                // color: lightGrey,
                                child: GridView.builder(
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(), //isaka use isliye kiye kyoko this widget ka itself scroller hota jise remove karane ke liye ham ise use kiye
                                    //jisase this widget can be scroll with body scroller
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap:
                                        true, //isako true isliye kar rahe h kyoki ham column ke inside me use kar rahe h
                                    itemCount: data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            mainAxisExtent: 250),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            data[index]['p_imgs'][0],
                                            width: 200,
                                            height: 150,
                                            fit: BoxFit.fill,
                                          )
                                              .box
                                              .rounded
                                              .padding(EdgeInsets.all(8))
                                              .make(),
                                          Spacer(), //equal space provide

                                          "${data[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          2.heightBox,
                                          "${data[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .fontFamily(bold1)
                                              .color(redColor)
                                              .align(TextAlign.end)
                                              .make()
                                              .box
                                              .margin(
                                                  EdgeInsets.only(bottom: 45))
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .outerShadowSm
                                          .roundedSM
                                          .make()
                                          .onTap(() {
                                        controller.checkIfFav(data[
                                            index]); //yadi data avilable hoga wishlist is index according isFav ko true kar dega nahi to false
                                        Get.to(() => ItemDetails(
                                              title: "${data[index]['p_name']}",
                                              data: data[index],
                                            ));
                                      });
                                    })));
                      }
                    }),
              ],
            )));
  }
}
