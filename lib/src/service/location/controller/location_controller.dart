// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../domain/local/preferences/local_storage_keys.dart';
// import '../../../domain/local/preferences/local_storage.dart';
// import '../../../global/utils/show_toast.dart';
// import '../../../initializer.dart';
// import '../view/location_permission_screen.dart';
//
// class LocationController extends GetxController {
//   static LocationController get current => Get.find();
//
//   String currentAddress = "Unknown";
//   String currentLatLon = "Unknown";
//   String? userSavedLocation;
//
//   Future getUserLocation() async {
//     var status = await Permission.location.status;
//     if (status.isDenied) {
//       await Permission.location.request();
//       Permission.location;
//     }
//
//     if (await Permission.location.isRestricted) {
//       // The OS restricts access, for example, because of parental controls.
//     }
//
//     try {
//       if (!(await Geolocator.isLocationServiceEnabled())) {
//         log("Open Settings");
//         await dialogOpenLocationSettings(Get.context!);
//         showCustomSnackBar("Location setting error. Could not continue.", icon: Icons.info);
//         return null;
//       }
//
//       LocationPermission permission = await Geolocator.checkPermission();
//
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           await dialogOpenAppSettings(Get.context!);
//           showCustomSnackBar("Location setting error. Could not continue.", icon: Icons.info);
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         await dialogOpenAppSettings(Get.context!);
//         showCustomSnackBar("Location setting error. Could not continue.", icon: Icons.info);
//         return null;
//       }
//
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
//       );
//
//       await setLocaleIdentifier('en_US');
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude
//       );
//       Placemark place = placemarks[0];
//
//       // ==@ Current Lat-Lon @==
//       currentLatLon = "${position.latitude}, ${position.longitude}";
//       log("Getting Current LatLon :@=> Latitude: ${position.latitude}, Longitude: ${position.longitude}");
//
//       // ==@ Current Address @==
//       currentAddress = '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
//       locator<LocalStorage>().setString(key: StorageKeys.currentAddress, value: currentAddress);
//       log("Getting Current Location :@=> $currentAddress");
//
//       locator<LocalStorage>().setString(key: StorageKeys.currentLatLong, value: currentLatLon);
//       locator<LocalStorage>().setString(key: StorageKeys.latitude, value: position.latitude.toString());
//       locator<LocalStorage>().setString(key: StorageKeys.longitude, value: position.longitude.toString());
//
//       update();
//     } catch (e, s) {
//       log('#Get Location Error:', error: e, stackTrace: s);
//       showCustomSnackBar("Unable to get location data", icon: Icons.info);
//     }
//
//     update();
//   }
//
//   Future checkLocationPermission() async {
//     PermissionStatus permissionStatus = await Permission.location.status;
//
//     if (permissionStatus.isGranted) {
//       log("Location Permission Granted");
//       await Get.find<LocationController>().getUserLocation();
//     } else if (permissionStatus.isDenied) {
//
//       log("Requesting Location Permission");
//       PermissionStatus newPermissionStatus = await Permission.location.request();
//
//       if (newPermissionStatus.isGranted) {
//         log("Location Permission Granted After Request");
//         await Get.find<LocationController>().getUserLocation();
//       } else {
//         log("Location Permission Denied");
//         showCustomSnackBar("Location permission denied. Please enable location services.", icon: Icons.info);
//       }
//     } else if (permissionStatus.isPermanentlyDenied) {
//
//       log("Location Permission Permanently Denied");
//       await dialogOpenAppSettings(Get.context!);
//     }
//
//   }
//
// }
