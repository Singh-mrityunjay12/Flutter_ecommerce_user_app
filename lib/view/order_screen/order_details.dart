import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/view/order_screen/component/order_place_detail.dart';
import 'package:music_app/view/order_screen/component/order_status.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data[0]['order_by_name']);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: " Placed",
                  showDone: data[0]['order_place']),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Conformed",
                  showDone: data[0]['order_confirmed']),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "On Deliver",
                  showDone: data[0]['order_on_delivered']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Delivered",
                  showDone: data[0]['order_delivered']),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                      title1: "Order_code",
                      title2: "Shipping_method",
                      d1: data[0]['order_code'],
                      d2: data[0]['sipping_method']),
                  orderPlaceDetails(
                      title1: "Order_date",
                      title2: "Payment_method",
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data[0]['order_date'].toDate())),
                      d2: data[0]['payment_Method']),
                  orderPlaceDetails(
                      title1: "Payment_status",
                      title2: "Delivery_status",
                      d1: "Unpaid",
                      d2: "Order Placed"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            "${data[0]['order_by_name']}".text.make(),
                            "${data[0]['order_by_email']}".text.make(),
                            "${data[0]['order_by_address']}"
                                .text
                                .maxLines(4)
                                .make(),
                            "${data[0]['order_by_city']}".text.make(),
                            "${data[0]['order_by_state']}".text.make(),
                            "${data[0]['order_by_phone']}".text.make(),
                            "${data[0]['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                                "${data[0]['total_amount']}".text.make(),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data[0]['orders'].length, (index) {
                  //List ham log children ke place per hi generate karate h
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: data[0]['orders'][index]['title'],
                          title2: data[0]['orders'][index]['total_price'],
                          d1: "${data[0]['orders'][index]['quantity']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data[0]['orders'][index]['color']),
                        ),
                      ),
                      Divider()
                    ],
                  );
                }).toList(), //vapas se list me convert kar sake usi ke liye use karate h
              )
                  .box
                  .outerShadowMd
                  .margin(EdgeInsets.only(bottom: 4))
                  .white
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
