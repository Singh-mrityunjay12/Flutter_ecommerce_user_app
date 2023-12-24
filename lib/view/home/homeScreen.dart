// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/list.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/const/text_style.dart';
import 'package:music_app/controller/homeScreenController.dart';
import 'package:music_app/controller/product_controller.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/categary_screen/itemDetail.dart';
import 'package:music_app/view/home/featured_button.dart';
import 'package:music_app/view/home/search_screen.dart';
import 'package:music_app/widget_common/home_Button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget_common/lodingindicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if (controller.searchController.text
                        .trim()
                        .isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text.trim(),
                          ));
                      // controller.searchController.clear();
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          //swipers brand
          Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      VxSwiper.builder(
                          //VxSwiper.builder is replace ListView.builder
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 160,
                          enlargeCenterPage: true,
                          itemCount: sliderList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.asset(
                                sliderList[index],
                                fit: BoxFit.fill,
                              )
                                  .box
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .margin(const EdgeInsets.symmetric(
                                      horizontal: 10))
                                  .make(),
                            );
                          }),
                      10.heightBox,
                      //deals button
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              2,
                              (index) => HomeButton(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth / 2.5,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashsale))),
                      //2nd swiper
                      10.heightBox,

                      VxSwiper.builder(
                          //VxSwiper.builder is replace ListView.builder
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 160,
                          enlargeCenterPage: true,
                          itemCount: sliderList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.asset(
                                secondsliderList[index],
                                fit: BoxFit.fill,
                              )
                                  .box
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .margin(const EdgeInsets.symmetric(
                                      horizontal: 10))
                                  .make(),
                            );
                          }),
                      10.heightBox,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              3,
                              (index) => HomeButton(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth / 3.5,
                                  icon: index == 0
                                      ? icTopCategories
                                      : index == 1
                                          ? icBrands
                                          : icTopSeller,
                                  title: index == 0
                                      ? topCategories
                                      : index == 1
                                          ? brand
                                          : topSellers))),
                      20.heightBox,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text
                              .color(darkFontGrey)
                              .size(18)
                              .fontFamily(semibold)
                              .make()),
                      10.heightBox,
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                3,
                                (index) => Column(
                                      children: [
                                        featuredButton(
                                            title: featuredTitle1[index],
                                            image: featuredImages1[index]),
                                        10.heightBox,
                                        featuredButton(
                                            title: featuredTitle2[index],
                                            image: featuredImages2[index])
                                      ],
                                    )),
                          )),
                      //featured product
                      20.heightBox,
                      Container(
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text
                                .fontFamily(bold)
                                .size(18)
                                .white
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder(
                                    future:
                                        FirestoreServices.getFeaturedProduct(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: LodingIndicator(),
                                        );
                                      } else {
                                        var feturedata = snapshot.data!.docs;
                                        return Row(
                                          children: List.generate(
                                              feturedata.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        feturedata[index]
                                                            ['p_imgs'][0],
                                                        width: 150,
                                                        height: 150,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      10.heightBox,
                                                      "${feturedata[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      10.heightBox,
                                                      "${feturedata[index]['p_price']}"
                                                          .numCurrency
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
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4))
                                                      .padding(
                                                          EdgeInsets.all(8))
                                                      .make()
                                                      .onTap(() {
                                                    var controller = Get.put(
                                                        ProductController());
                                                    Get.to(() => ItemDetails(
                                                          title:
                                                              "${feturedata[index]['p_name']}",
                                                          data:
                                                              feturedata[index],
                                                        ));
                                                  })),
                                        );
                                      }
                                    }))
                          ],
                        ),
                      ),
                      //third swiper
                      20.heightBox,

                      VxSwiper.builder(
                          //VxSwiper.builder is replace ListView.builder
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 160,
                          enlargeCenterPage: true,
                          itemCount: sliderList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.asset(
                                secondsliderList[index],
                                fit: BoxFit.fill,
                              )
                                  .box
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .margin(const EdgeInsets.symmetric(
                                      horizontal: 10))
                                  .make(),
                            );
                          }),
                      //all product section
                      20.heightBox,
                      //At the place of StreamBuilder() We can also use FutureBuilder()
                      StreamBuilder(
                          stream: FirestoreServices.allProduct(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: LodingIndicator(),
                              );
                            } else {
                              var allproductsdata = snapshot.data!.docs;
                              return GridView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(), //isaka use isliye kiye kyoko this widget ka itself scroller hota jise remove karane ke liye ham ise use kiye
                                  //jisase this widget can be scroll with body scroller
                                  shrinkWrap:
                                      true, //isako true isliye kar rahe h kyoki ham column ke inside me use kar rahe h
                                  itemCount: allproductsdata.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          mainAxisExtent: 300),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Image.network(
                                            allproductsdata[index]['p_imgs'][0],
                                            width: 130,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Spacer(), //equal space provide
                                        "${allproductsdata[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${allproductsdata[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .fontFamily(bold1)
                                            .color(redColor)
                                            .make()
                                      ],
                                    ).box.white.roundedSM.make().onTap(() {
                                      var controller = Get.put(
                                          ProductController()); //here hame ProductController() isliye initialized karvana pada kyoki ItemDetails() screen me ham ProductController() ko find kar rahe h
                                      //initialized nahi kar rah h fiind kar rahe h
                                      Get.to(() => ItemDetails(
                                            title:
                                                "${allproductsdata[index]['p_name']}",
                                            data: allproductsdata[index],
                                          ));
                                    });
                                  });
                            }
                          })
                    ],
                  ))),
        ],
      )),
    );
  }
}
