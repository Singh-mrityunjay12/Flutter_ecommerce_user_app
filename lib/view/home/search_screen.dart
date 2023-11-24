import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/widget_common/lodingindicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../const/style.dart';
import '../../controller/product_controller.dart';
import '../categary_screen/itemDetail.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Product is found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!
                            .toLowerCase()), //aise hamlog search ke through data access karate  and filter the data that what should we
                  )
                  .toList();
              print(data[0]['p_name']);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      mainAxisExtent: 320),
                  children: filtered
                      .mapIndexed(
                        (currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filtered[index]['p_imgs'][0],
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                            Spacer(), //equal space provide
                            "${filtered[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['p_price']}"
                                .numCurrency
                                .text
                                .fontFamily(bold1)
                                .color(redColor)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .outerShadowMd
                            .padding(EdgeInsets.all(12))
                            .roundedSM
                            .make()
                            .onTap(() {
                          var controller = Get.put(
                              ProductController()); //here hame ProductController() isliye initialized karvana pada kyoki ItemDetails() screen me ham ProductController() ko find kar rahe h
                          //initialized nahi kar rah h fiind kar rahe h
                          Get.to(() => ItemDetails(
                                title: "${filtered[index]['p_name']}",
                                data: filtered[index],
                              ));
                        }),
                      )
                      .toList(), //jab GridView.builder() jab use nahi karate h to aise value get karete h
                ),
              );
            }
          }),
    );
  }
}
