// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// import '../../../global/constants/colors_resources.dart';
// import '../../../global/widget/global_bottom_widget.dart';
// import '../../../global/widget/global_sized_box.dart';
// import '../../../global/widget/global_text.dart';
//
// // ==============
// Future<void> dialogOpenLocationSettings(BuildContext context) async {
//   return Get.dialog(
//     AlertDialog(
//       title: const Text('Turn on location services'),
//       content: const Text(
//           'Untuk mengenal pasti lokasi kejadian semasa anda, sila benarkan lokasi.\nPergi ke Tetapan > Privasi > KomunitiKu > benarkan kebenaran lokasi'),
//       actions: [
//         TextButton(
//           onPressed: () {
//             // Navigator.pop(context);
//             Get.back();
//           },
//           child: const Text('BATAL'),
//         ),
//         TextButton(
//           onPressed: () async {
//             await Geolocator.openLocationSettings();
//           },
//           child: Text(
//             'Settings'.toUpperCase(),
//             style: const TextStyle(color: Colors.red),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Future<void> dialogOpenAppSettings(BuildContext context) async {
//   return Get.dialog(
//       AlertDialog(
//         backgroundColor: ColorRes.primaryColor.withOpacity(0.9),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//         content: SizedBox(
//           width: Get.width,
//           child: NotificationListener<OverscrollIndicatorNotification>(
//             onNotification: (overScroll) {
//               overScroll.disallowIndicator();
//               return true;
//             },
//             child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     sizedBoxH(20),
//                     const GlobalText(
//                       str: "Permission is Required",
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: ColorRes.white,
//                     ),
//
//                     sizedBoxH(10),
//                     const GlobalText(
//                       str: "To identify your current event location, please allow location.",
//                       fontWeight: FontWeight.w400,
//                       fontSize: 13,
//                       color: ColorRes.grey,
//                       textAlign: TextAlign.center,
//                     ),
//                     const GlobalText(
//                       str: "Go to Settings > Privacy > My Community > Allow Location Permission.",
//                       fontWeight: FontWeight.w400,
//                       fontSize: 13,
//                       color: ColorRes.grey,
//                       textAlign: TextAlign.center,
//                     ),
//
//                     sizedBoxH(20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: GlobalButtonWidget(
//                             str: "Deny",
//                             height: 40,
//                             textSize: 13,
//                             onTap: (){
//                               Get.back();
//                             },
//                           ),
//                         ),
//
//                         sizedBoxW(10),
//                         Expanded(
//                           child: GlobalButtonWidget(
//                             str: "Go To Settings",
//                             height: 40,
//                             buttomColor: ColorRes.primaryColor,
//                             radius: 5,
//                             textSize: 13,
//                             onTap: () async{
//                               await Geolocator.openAppSettings();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     sizedBoxH(20),
//                   ],
//                 )
//             ),
//           ),
//         ),
//       )
//   );
// }
//
// // Future<void> dialogOpenAppSettings(BuildContext context) async {
// //   return Get.dialog(
// //     AlertDialog(
// //       title: const Text('Permission is Required'),
// //       content: const Text(
// //           'Untuk mengenal pasti lokasi kejadian semasa anda, sila benarkan lokasi.\nPergi ke Tetapan > Privasi > KomunitiKu > benarkan kebenaran lokasi'),
// //       actions: [
// //         TextButton(
// //           onPressed: () {
// //             // Navigator.pop(context);
// //             Get.back();
// //           },
// //           child: const Text('BATAL'),
// //         ),
// //         TextButton(
// //           onPressed: () async {
// //             await Geolocator.openAppSettings();
// //           },
// //           child: Text(
// //             'tetapan'.toUpperCase(),
// //             style: const TextStyle(color: Colors.red),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
