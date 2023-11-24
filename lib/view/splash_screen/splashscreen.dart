// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/firebase_const.dart';
import 'package:music_app/const/images.dart';
import 'package:music_app/const/string.dart';
import 'package:music_app/const/style.dart';
import 'package:music_app/const/text_style.dart';
// import 'package:music_app/users/authentication/loginscreen.dart';
import 'package:music_app/view/auth_screen/loginScreen.dart';
import 'package:music_app/view/home/home.dart';
import 'package:music_app/widget_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //created a method to change the screen
  ChangeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      //using getX
      // Get.to(() => LoginScreen());
      auth.authStateChanges().listen((User? user) {
        print(
            "///////////////////////////////////////////////////////////////////////////////////");
        print(user);
        if (user == null && mounted) {
          //yadi user nahi login hoga tab ham log login page per jayege
          Get.to(() => LoginScreen());
        } else {
          Get.to(() =>
              Home()); //yadi user login hoga tab hamlog homePage per chale jayenge
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChangeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
                // height: 200,
                fit: BoxFit.cover,
              )),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          applogoWidget(),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
          Text(
            appname,
            style:
                TextStyle(fontFamily: bold1, fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(appversion, style: TextStyle(color: Colors.white)),
          Spacer(), //use for responsive height ,Creates a flexible space to insert into a [Flexible] widget.
          Text(credits,
              style: TextStyle(fontFamily: semibold, color: Colors.white)),
          SizedBox(
            height: 30,
          )
          //our splash screen ui is completed
        ]),
      ),
    );
  }
}
