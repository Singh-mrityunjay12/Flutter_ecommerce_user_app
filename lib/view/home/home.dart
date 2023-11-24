import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/controller/homeScreenController.dart';
import 'package:music_app/view/cart_Screen/CartScreen.dart';
import 'package:music_app/view/categary_screen/categaryScreen.dart';
import 'package:music_app/view/home/homeScreen.dart';
import 'package:music_app/view/profile_Screen/profileScreen.dart';
import 'package:music_app/widget_common/exitDialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //initialized home controller
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 40,
            height: 50,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 40,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 40,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 40,
          ),
          label: account),
    ];
    var navbody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
        onWillPop: () async {
          showDialog(
              barrierDismissible:
                  false, //isaka use karane ham dialog box outside click karenge to close nahi hoga
              context: (context),
              builder: (context) => exitDialog(context));
          return false;
        },
        child: Scaffold(
            body: Column(
              children: [
                Obx(() => Expanded(
                    child:
                        navbody.elementAt(controller.currentNavIndex.value))),
              ],
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: controller.currentNavIndex.value,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: redColor,
                selectedLabelStyle: const TextStyle(fontFamily: semibold),
                iconSize: 20,
                items: navbarItem,
                backgroundColor: whiteColor,
                onTap: (value) {
                  print(value);
                  controller.currentNavIndex.value = value;
                },
              ),
            )));
  }
}
