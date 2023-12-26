import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/services/firestore_service.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget_common/lodingindicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
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
              print(data);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async {
                              //here data[index].id ye field id nahi h ye document id h field id means currentUser!.uid fild id database me store rahata h aur database jis id per store hota h use docId kahate h

                              await firestore
                                  .collection(productCollection)
                                  .doc(data[index].id)
                                  .set({
                                'p_wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid]),
                              }, SetOptions(merge: true));

                              ///  SetOption() true karane se left item ko merge karata h jisase vo kisi aur se replace na ho paye

                              print("///////////////////////////////////////A");
                              print(data[index].id);
                              print("///////////////////////////////////////B");
                            }),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
