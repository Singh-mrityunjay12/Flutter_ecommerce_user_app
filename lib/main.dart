import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_app/Pages/HomePage.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/text_style.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/view/splash_screen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //we are using getX so we have to change materialApp into GetMaterialApp
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          fontFamily: regular,
          scaffoldBackgroundColor: Colors.transparent,
          //
          appBarTheme: const AppBarTheme(
              //to set app bar icons color
              iconTheme: IconThemeData(color: darkFontGrey),
              backgroundColor: Colors.transparent,
              elevation: 0),
          // primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
