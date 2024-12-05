
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/local/preferences/local_storage.dart';
import 'domain/server/http_client/app_config.dart';
import 'global/constants/enum.dart';
import 'initializer.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeApp();
  }

  // ==# App Initialization Logic
  Future<void> _initializeApp() async {
    LocalStorage localStorage = LocalStorage();
    AppUrlExtention.setUrl(UrlLink.isDev);
    await localStorage.initLocalStorage();
    await init(localStorage);
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Column(children: [],),),
    );
  }
}

// import 'dart:async';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ott_app/src/features/splash_screen/view/splash_screen.dart';
// import 'package:ott_app/src/features/video_details/view/movie_video_details_screen.dart';
// import 'domain/local/preferences/local_storage.dart';
// import 'domain/server/http_client/app_config.dart';
// import 'global/constants/enum.dart';
// import 'global/method/get_device_info.dart';
// import 'initializer.dart';
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
//
// }
//
// class _MyAppState extends State<MyApp> {
//
//   late AppLinks _appLinks;
//   StreamSubscription<Uri>? _linkSubscription;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _initializeApp();
//     initDeepLinks();
//   }
//
//   // ==# App Initialization Logic
//   Future<void> _initializeApp() async {
//     LocalStorage localStorage = LocalStorage();
//     AppUrlExtention.setUrl(UrlLink.isDev);
//     await localStorage.initLocalStorage();
//     await init(localStorage);
//     await GetDeviceInfo.getDeviceInfo();
//   }
//
//   Future<void> initDeepLinks() async {
//     _appLinks = AppLinks();
//     // Listen to deep links
//     _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         final slug = uri.queryParameters['slug'];
//         if (slug != null) {
//           // Navigate to the MovieVideoDetailsScreen with the movie slug
//           _navigateToMovieDetails(slug);
//         }
//       }
//     });
//   }
//
//   void _navigateToMovieDetails(String slug) {
//     Get.to(()=> MovieVideoDetailsScreen(slug: slug));
//   }
//
//   @override
//   void dispose() {
//     _linkSubscription?.cancel();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }
