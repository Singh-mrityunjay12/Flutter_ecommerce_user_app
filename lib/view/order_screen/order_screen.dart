import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/const/text_style.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:music_app/view/order_screen/order_details.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget_common/lodingindicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrder(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Order yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .xl
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrderDetails(
                                data: data,
                              ));
                          print(data[index]['order_place']);
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        color: darkFontGrey,
                      ),
                    );
                  });
            }
          }),
    );
  }
}
