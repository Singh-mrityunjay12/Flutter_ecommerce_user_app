import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/const/color.dart';
import 'package:music_app/const/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          //tralling
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text(
            "Beats",
            style: ourStyle(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 100,
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(
                    "Music Name",
                    style: ourStyle(family: bold, size: 15),
                  ),
                  tileColor: bgColor,
                  subtitle: Text(
                    "Artist Name",
                    style: ourStyle(family: bold, size: 13),
                  ),
                  leading: Icon(
                    Icons.music_note,
                    color: whiteColor,
                    size: 32,
                  ),
                  trailing: Icon(Icons.play_arrow, color: whiteColor, size: 26),
                ),
              );
            },
          ),
        ));
  }
}
