// import 'dart:typed_data';

// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PlayerController extends GetxController {
//   final audioQuery = OnAudioQuery();

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     checkPermission();
//   }

//   Future<List<SongModel>> checkPermission() async {
//     var perm = await Permission.storage.request();
//     //check status code
//     if (perm.isGranted) //means permission mil gaya
//     {
//       return audioQuery.querySongs(
//           ignoreCase: false,
//           orderType: OrderType
//               .ASC_OR_SMALLER, //means return alphabatical order in ascending order,
//           sortType: null,
//           uriType: UriType.EXTERNAL);
//     } else {
//       return checkPermission();
//     }
//   }
// }
