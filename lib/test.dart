//
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../global/constants/colors_resources.dart';
// import '../../global/constants/date_time_formatter.dart';
// import '../../global/constants/enum.dart';
// import '../../global/constants/input_decoration.dart';
// import '../../global/method/show_date_time_picker.dart';
// import '../../global/utils/show_toast.dart';
// import '../../global/widget/global_appbar.dart';
// import '../../global/widget/global_bottom_widget.dart';
// import '../../global/widget/global_container.dart';
// import '../../global/widget/global_image_loader.dart';
// import '../../global/widget/global_progress_hub.dart';
// import '../../global/widget/global_search_text_formfield.dart';
// import '../../global/widget/global_sized_box.dart';
// import '../../global/widget/global_text.dart';
// import '../../global/widget/global_textform_field.dart';
// import '../auth/controller/auth_controller.dart';
// import 'controller/vehicle_requisition_controller.dart';
//
// class RequisitionEntryScreen extends StatefulWidget {
//   const RequisitionEntryScreen({super.key});
//
//   @override
//   State<RequisitionEntryScreen> createState() => _RequisitionEntryScreenState();
// }
//
// class _RequisitionEntryScreenState extends State<RequisitionEntryScreen> {
//
//   final ScrollController scrollController = ScrollController();
//
//   String accessibility = 'নির্বাচন করুন';
//   final List<String> publicPrivateOptions = ['সরকারি', 'বেসরকারি'];
//   TextEditingController requestDateCon = TextEditingController();
//   TextEditingController toDayDateCon = TextEditingController();
//   TextEditingController fromTimeCon = TextEditingController();
//   TextEditingController toTimeCon = TextEditingController();
//   TextEditingController toLocationCon = TextEditingController();
//   String selectDistrict = '0';
//   TextEditingController totalMileageCon = TextEditingController();
//   String expenditureSector = 'নির্বাচন করুন';
//   final List<String> expenditureSectorList = ['রাজস্ব', 'প্রকল্প'];
//   String selectVehicleType = '0';
//   TextEditingController projectNameCon = TextEditingController();
//   TextEditingController numberOfPassengersCon = TextEditingController();
//   String selectEmployee = '0';
//   TextEditingController purposeCon = TextEditingController();
//   TextEditingController detailsCon = TextEditingController();
//
//   List<Widget> passengerRows = [];
//   // List to store selected employee for each row
//   List<String?> selectedEmployeeList = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     final vehicleRequisitionController = VehicleRequisitionController.current;
//     vehicleRequisitionController.getVehicleTypeList();
//     vehicleRequisitionController.getDistrictList();
//     vehicleRequisitionController.getEmployeeList();
//
//     String formattedToday = DateTimeFormatter.showDateOnly.format(DateTime.now());
//     toDayDateCon = TextEditingController(text: formattedToday);
//
//     // Listen for changes in numberOfPassengersCon to update passenger rows
//     numberOfPassengersCon.addListener(_updatePassengerRows);
//   }
//
//   void _updatePassengerRows() {
//     final vehicleRequisitionController = VehicleRequisitionController.current;
//     int numberOfRows = int.tryParse(numberOfPassengersCon.text) ?? 0;
//
//     // Adjust the selectedEmployeeList size based on the number of rows
//     if (numberOfRows > selectedEmployeeList.length) {
//       selectedEmployeeList.addAll(List<String?>.filled(numberOfRows - selectedEmployeeList.length, null));
//     } else if (numberOfRows < selectedEmployeeList.length) {
//       selectedEmployeeList = selectedEmployeeList.sublist(0, numberOfRows);
//     }
//
//     setState(() {
//       passengerRows = List.generate(numberOfRows, (index) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: GlobalSearchTextFormField(
//                   titleText: 'কর্মী নির্বাচন ${index + 1}',
//                   text: selectedEmployeeList[index] ?? '',
//                   color: vehicleRequisitionController.selectEmployeeIndex > -1 ? ColorRes.black : ColorRes.grey,
//                   item: vehicleRequisitionController.selectEmployeeList ?? [],
//                   onSelect: (val) async {
//                     setState(() {
//                       Get.back();
//                       selectedEmployeeList[index] = vehicleRequisitionController.selectEmployeeList![val];
//                       vehicleRequisitionController.selectEmployeeIndex = val;
//                       vehicleRequisitionController.selectEmployee = selectedEmployeeList[index]!;
//
//                       // Log the selected ID for debugging
//                       final employeeId = vehicleRequisitionController.employeeListData?[
//                       vehicleRequisitionController.selectEmployeeList!.indexOf(selectedEmployeeList[index]!)].id.toString();
//
//                       log('Selected Employee ID: $employeeId');
//                       log('Selected Employee ID List: $selectedEmployeeList');
//                       if (employeeId != null) {
//                         selectEmployee = employeeId;
//                       }
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                 margin: const EdgeInsets.only(bottom: 5),
//                 decoration: BoxDecoration(
//                   color: ColorRes.red,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: const Icon(
//                   Icons.remove,
//                   color: ColorRes.white,
//                 ),
//               ),
//             ],
//           ),
//         );
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     numberOfPassengersCon.removeListener(_updatePassengerRows);
//     numberOfPassengersCon.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VehicleRequisitionController>(builder: (vehicleRequisitionController){
//       return GetBuilder<AuthController>(builder: (authController){
//         return Scaffold(
//           appBar: const PreferredSize(
//               preferredSize: Size.fromHeight(60),
//               child: GlobalAppBar(
//                   str: 'যানবাহন ব্যবহারের অনুরোধপত্র'
//               )),
//           body: ProgressHUD(
//             inAsyncCall: vehicleRequisitionController.isLoading,
//             child: GlobalContainer(
//               height: size(context).height,
//               width: size(context).width,
//               color: Colors.white,
//               child: NotificationListener<OverscrollIndicatorNotification>(
//                 onNotification: (overScrol) {
//                   overScrol.disallowIndicator();
//                   return true;
//                 },
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: Column(
//                     children: [
//
//                       sizedBoxH(20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GlobalImageLoader(
//                             imagePath: authController.informationModel?.data?.logo ?? "",
//                             height: 70,
//                             width: 70,
//                             imageFor: ImageFor.network,
//                           ),
//
//                           sizedBoxW(5),
//                           Flexible(
//                             child: Column(
//                               children: [
//                                 GlobalText(
//                                   str: authController.informationModel?.data?.name ?? "",
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 GlobalText(
//                                   str: authController.informationModel?.data?.address ?? "",
//                                   fontWeight: FontWeight.w400,
//                                   textAlign: TextAlign.center,
//                                   fontSize: 15,
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           sizedBoxW(5),
//                           GlobalImageLoader(
//                             imagePath: authController.informationModel?.data?.govtLogo ?? "",
//                             height: 70,
//                             width: 70,
//                             imageFor: ImageFor.network,
//                           ),
//                         ],
//                       ),
//
//                       sizedBoxH(5),
//                       Container(
//                         color: ColorRes.deepPurple,
//                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                         child: const GlobalText(
//                           str: "যানবাহন ব্যবহারের অনুরোধপত্র",
//                           color: ColorRes.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 13,
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Column(
//                           children: [
//
//                             sizedBoxH(20),
//                             GlobalSearchTextFormField(
//                               titleText: 'আবেদনের প্রকার',
//                               text: accessibility,
//                               color: ColorRes.black,
//                               item: publicPrivateOptions,
//                               isRequired: true,
//                               onSelect: (val) async {
//                                 setState(() {
//                                   accessibility = publicPrivateOptions[val];
//                                   Get.back();
//                                 });
//                                 log("Selected Accessibility: ${publicPrivateOptions[val]}"); // Debugging line
//                               },
//                             ),
//
//                             sizedBoxH(10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: requestDateCon,
//                                     titleText: 'ব্যবহারের তারিখ',
//                                     decoration: dateInputDecoration,
//                                     prefixIcon: GestureDetector(
//                                         onTap: () async{
//                                           var pickedDate = await showDateOnlyPicker(context);
//                                           setState(() {
//                                             String formatedDate = DateTimeFormatter.showDateOnly.format(pickedDate);
//                                             requestDateCon.text = formatedDate;
//                                           });
//                                         },
//                                         child: const Icon(Icons.calendar_month_outlined, color: ColorRes.grey, size: 20)
//                                     ),
//                                     isRequired: true,
//                                     isDense: true,
//                                   ),
//                                 ),
//                                 sizedBoxW(10),
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: toDayDateCon,
//                                     titleText: 'আবেদনের তারিখ',
//                                     decoration: dateInputDecoration,
//                                     prefixIcon: GestureDetector(
//                                         onTap: () async{
//                                           var pickedDate = await showDateOnlyPicker(context);
//                                           setState(() {
//                                             String formatedDate = DateTimeFormatter.showDateOnly.format(pickedDate);
//                                             toDayDateCon.text = formatedDate;
//                                           });
//                                         },
//                                         child: const Icon(Icons.calendar_month_outlined, color: ColorRes.grey, size: 20)
//                                     ),
//                                     isRequired: true,
//                                     isDense: true,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             sizedBoxH(10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: fromTimeCon,
//                                     titleText: 'সময় থেকে',
//                                     decoration: dateInputDecoration,
//                                     prefixIcon: GestureDetector(
//                                       onTap: () async {
//                                         var selectedTime = await showTimeOnlyPicker(context);
//                                         if (selectedTime != null) {
//                                           final now = DateTime.now();
//                                           final dateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
//                                           String formattedTime = DateTimeFormatter.showTimeWithSeconds.format(dateTime);
//
//                                           setState(() {
//                                             fromTimeCon.text = formattedTime;
//                                           });
//                                         }
//                                       },
//                                       child: const Icon(Icons.access_time_outlined, color: ColorRes.grey, size: 20),
//                                     ),
//                                     isRequired: true,
//                                     isDense: true,
//                                   ),
//                                 ),
//                                 sizedBoxW(10),
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: toTimeCon,
//                                     titleText: 'সময় পর্যন্ত',
//                                     decoration: dateInputDecoration,
//                                     prefixIcon: GestureDetector(
//                                       onTap: () async {
//                                         var selectedTime = await showTimeOnlyPicker(context);
//                                         if (selectedTime != null) {
//                                           final now = DateTime.now();
//                                           final dateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
//                                           String formattedTime = DateTimeFormatter.showTimeWithSeconds.format(dateTime);
//
//                                           setState(() {
//                                             toTimeCon.text = formattedTime;
//                                           });
//                                         }
//                                       },
//                                       child: const Icon(Icons.access_time_outlined, color: ColorRes.grey, size: 20),
//                                     ),
//                                     isRequired: true,
//                                     isDense: true,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             sizedBoxH(10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: GlobalSearchTextFormField(
//                                     titleText: 'গন্তব্যস্থল জেলা',
//                                     text: vehicleRequisitionController.selectDistrict,
//                                     color: vehicleRequisitionController.selectDistrictIndex > -1 ? ColorRes.black : ColorRes.grey,
//                                     item:  vehicleRequisitionController.selectDistrictList ?? [],
//                                     isRequired: true,
//                                     onSelect: (val) async{
//                                       setState((){
//                                         Get.back();
//                                         vehicleRequisitionController.selectDistrictIndex = val;
//                                         vehicleRequisitionController.selectDistrict = vehicleRequisitionController.selectDistrictList![val];
//
//                                         final districtType = vehicleRequisitionController.districtData?[
//                                         vehicleRequisitionController.selectDistrictList!.indexOf(vehicleRequisitionController.selectDistrict)
//                                         ].id.toString();
//
//                                         log('Drop Main Id: $districtType');
//                                         if(districtType != null){
//                                           selectDistrict = districtType.toString();
//
//                                         } else{
//                                           log('Drop Id: $selectDistrict');
//                                         }
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 sizedBoxW(10),
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: toLocationCon,
//                                     titleText: 'গন্তব্যস্থান',
//                                     hintText: 'যাত্রার গন্তব্য লিখুন',
//                                     decoration: borderDecoration,
//                                     isDense: true,
//                                     isRequired: true,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             sizedBoxH(10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: totalMileageCon,
//                                     titleText: 'ভ্রমণের আনুমানিক মোট মাইলেজ',
//                                     hintText: 'মোট মাইলেজ লিখুন',
//                                     decoration: borderDecoration,
//                                     isDense: true,
//                                   ),
//                                 ),
//
//                                 sizedBoxW(10),
//                                 Expanded(
//                                   child: GlobalSearchTextFormField(
//                                     titleText: 'খরচের খাত',
//                                     text: expenditureSector,
//                                     color: ColorRes.black,
//                                     item: expenditureSectorList,
//                                     onSelect: (val) async {
//                                       setState(() {
//                                         expenditureSector = expenditureSectorList[val];
//                                         Get.back();
//                                       });
//                                       log("Selected Accessibility: ${expenditureSectorList[val]}"); // Debugging line
//                                     },
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//
//                             sizedBoxH(10),
//                             GlobalTextFormField(
//                               controller: projectNameCon,
//                               titleText: 'প্রকল্পের নাম',
//                               hintText: 'প্রকল্পের নাম লিখুন',
//                               decoration: borderDecoration,
//                               isDense: true,
//                             ),
//
//                             sizedBoxH(10),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: GlobalSearchTextFormField(
//                                     titleText: 'যানবাহনের প্রকার',
//                                     text: vehicleRequisitionController.selectVehicleType,
//                                     color: vehicleRequisitionController.selectVehicleTypeIndex > -1 ? ColorRes.black : ColorRes.grey,
//                                     item:  vehicleRequisitionController.selectVehicleTypeList ?? [],
//                                     isRequired: true,
//                                     onSelect: (val) async{
//                                       setState((){
//                                         Get.back();
//                                         vehicleRequisitionController.selectVehicleTypeIndex = val;
//                                         vehicleRequisitionController.selectVehicleType = vehicleRequisitionController.selectVehicleTypeList![val];
//
//                                         final vehicleType = vehicleRequisitionController.vehicleTypeListData?[
//                                         vehicleRequisitionController.selectVehicleTypeList!.indexOf(vehicleRequisitionController.selectVehicleType)
//                                         ].id.toString();
//
//                                         log('Drop Main Id: $vehicleType');
//                                         if(vehicleType != null){
//                                           selectVehicleType = vehicleType.toString();
//                                           // vehicleRequisitionController.reqTypeWiseVehicleList(typeId: selectVehicleType);
//                                         } else{
//                                           log('Drop Id: $selectVehicleType');
//                                         }
//                                       });
//
//                                     },
//                                   ),
//                                 ),
//
//                                 sizedBoxW(10),
//
//                                 Expanded(
//                                   child: GlobalTextFormField(
//                                     controller: numberOfPassengersCon,
//                                     titleText: 'যাত্রী সংখ্যা',
//                                     hintText: 'যাত্রী সংখ্যা লিখুন',
//                                     decoration: borderDecoration,
//                                     keyboardType: TextInputType.number,
//                                     isDense: true,
//                                     isRequired: true,
//                                   ),
//                                 ),
//
//
//                               ],
//                             ),
//
//                             sizedBoxH(10),
//                             ...passengerRows,
//
//                             sizedBoxH(10),
//                             GlobalTextFormField(
//                               controller: purposeCon,
//                               titleText: 'ব্যবহারের উদ্দেশ্য',
//                               hintText: "ব্যবহারের উদ্দেশ্য লিখুন",
//                               decoration: dateInputDecoration,
//                               isDense: true,
//                               isRequired: true,
//                             ),
//
//                             sizedBoxH(10),
//                             GlobalTextFormField(
//                               controller: detailsCon,
//                               titleText: 'বিশেষ বক্তব্য (যদি থাকে)',
//                               hintText: "এখানে আপনার প্রয়োজনীয়তা টাইপ করুন (যদি থাকে)",
//                               decoration: dateInputDecoration,
//                               isDense: true,
//                               maxLine: 3,
//                             ),
//
//                             sizedBoxH(30),
//                             GlobalButtonWidget(
//                                 str: 'জমা দিন',
//                                 height: 40,
//                                 radius: 8,
//                                 textSize: 12,
//                                 buttomColor: ColorRes.primaryColor,
//                                 onTap: () async{
//                                   if(accessibility != 'নির্বাচন করুন'){
//                                     if(requestDateCon.text.isNotEmpty){
//                                       if(toDayDateCon.text.isNotEmpty){
//                                         if(fromTimeCon.text.isNotEmpty){
//                                           if(toTimeCon.text.isNotEmpty){
//                                             if(selectDistrict != "0"){
//                                               if(toLocationCon.text.isNotEmpty){
//                                                 if(selectVehicleType != '0'){
//                                                   if(numberOfPassengersCon.text.isNotEmpty){
//                                                     if(purposeCon.text.isNotEmpty){
//                                                       vehicleRequisitionController.reqVehicleRequisition(
//                                                           accessibility: accessibility,
//                                                           requestDate: requestDateCon.text.trim(),
//                                                           toDayDate: toDayDateCon.text.trim(),
//                                                           fromTime: fromTimeCon.text.trim(),
//                                                           toTime: toTimeCon.text.trim(),
//                                                           districtId: selectDistrict,
//                                                           toLocation: toLocationCon.text.trim(),
//                                                           totalMileage: totalMileageCon.text.trim(),
//                                                           expenditureSector: expenditureSector,
//                                                           projectName: projectNameCon.text.trim(),
//                                                           vehicleType: selectVehicleType,
//                                                           numberOfPassengers: numberOfPassengersCon.text.trim(),
//                                                           purpose: purposeCon.text.trim(),
//                                                           details: detailsCon.text.trim(),
//                                                           onClear: (){
//                                                             setState(() {
//                                                               Get.back();
//                                                             });
//                                                           }
//                                                       );
//                                                     }else{
//                                                       showCustomSnackBar("ব্যবহারের উদ্দেশ্য প্রয়োজন", icon: Icons.info);
//                                                     }
//                                                   }else{
//                                                     showCustomSnackBar("যাত্রী সংখ্যা প্রয়োজন", icon: Icons.info);
//                                                   }
//                                                 }else{
//                                                   showCustomSnackBar("যানবাহনের প্রকার প্রয়োজন", icon: Icons.info);
//                                                 }
//                                               }else{
//                                                 showCustomSnackBar("গন্তব্যস্থান প্রয়োজন", icon: Icons.info);
//                                               }
//                                             }else{
//                                               showCustomSnackBar("গন্তব্যস্থল জেলা প্রয়োজন", icon: Icons.info);
//                                             }
//                                           }else{
//                                             showCustomSnackBar("সময় পর্যন্ত প্রয়োজন", icon: Icons.info);
//                                           }
//                                         }else{
//                                           showCustomSnackBar("সময় থেকে প্রয়োজন", icon: Icons.info);
//                                         }
//                                       }else{
//                                         showCustomSnackBar("আবেদনের তারিখ প্রয়োজন", icon: Icons.info);
//                                       }
//                                     }else{
//                                       showCustomSnackBar("ব্যবহারের তারিখ প্রয়োজন", icon: Icons.info);
//                                     }
//                                   }else{
//                                     showCustomSnackBar("আবেদনের প্রকার প্রয়োজন", icon: Icons.info);
//                                   }
//                                 }
//                             ),
//
//                             sizedBoxH(20),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       });
//     });
//   }
// }
//
// // sizedBoxH(30),
// // GlobalButtonWidget(
// //     str: 'জমা',
// //     height: 40,
// //     radius: 8,
// //     textSize: 12,
// //     buttomColor: ColorRes.primaryColor,
// //     onTap: () async{
// //       if(accessibility != 'নির্বাচন করুন'){
// //         if(requestDateCon.text.isNotEmpty){
// //           if(toDayDateCon.text.isNotEmpty){
// //             if(fromTimeCon.text.isNotEmpty){
// //               if(toTimeCon.text.isNotEmpty){
// //                 if(toLocationCon.text.isNotEmpty){
// //                   if(selectDistrict != "0"){
// //                     if(totalMileageCon.text.isNotEmpty){
// //                       if(expenditureSector != 'নির্বাচন করুন'){
// //                         if(projectNameCon.text.isNotEmpty){
// //                           if(selectVehicleType != '0'){
// //                             if(numberOfPassengersCon.text.isNotEmpty){
// //                               if(purposeCon.text.isNotEmpty){
// //                                 if(detailsCon.text.isNotEmpty){
// //                                   vehicleRequisitionController.reqVehicleRequisition(
// //                                       accessibility: accessibility,
// //                                       requestDate: requestDateCon.text.trim(),
// //                                       toDayDate: toDayDateCon.text.trim(),
// //                                       fromTime: fromTimeCon.text.trim(),
// //                                       toTime: toTimeCon.text.trim(),
// //                                       districtId: selectDistrict,
// //                                       toLocation: toLocationCon.text.trim(),
// //                                       totalMileage: totalMileageCon.text.trim(),
// //                                       expenditureSector: expenditureSector,
// //                                       projectName: projectNameCon.text.trim(),
// //                                       vehicleType: selectVehicleType,
// //                                       numberOfPassengers: numberOfPassengersCon.text.trim(),
// //                                       purpose: purposeCon.text.trim(),
// //                                       details: detailsCon.text.trim(),
// //                                       onClear: (){
// //
// //                                       }
// //                                   );
// //                                 }else{
// //                                   showCustomSnackBar("বিশেষ বক্তব্য প্রয়োজন", icon: Icons.info);
// //                                 }
// //                               }else{
// //                                 showCustomSnackBar("ব্যবহারের উদ্দেশ্য প্রয়োজন", icon: Icons.info);
// //                               }
// //                             }else{
// //                               showCustomSnackBar("যাত্রী সংখ্যা প্রয়োজন", icon: Icons.info);
// //                             }
// //                           }else{
// //                             showCustomSnackBar("যানবাহনের ধরন নির্বাচন প্রয়োজন", icon: Icons.info);
// //                           }
// //                         }else{
// //                           showCustomSnackBar("প্রকল্পের নাম প্রয়োজন", icon: Icons.info);
// //                         }
// //                       }else{
// //                         showCustomSnackBar("খরচের খাত প্রয়োজন", icon: Icons.info);
// //                       }
// //                     }else{
// //                       showCustomSnackBar("আনুমানিক মোট মাইলেজ প্রয়োজন", icon: Icons.info);
// //                     }
// //                   }else{
// //                     showCustomSnackBar("গন্তব্যস্থল জেলা প্রয়োজন", icon: Icons.info);
// //                   }
// //                 }else{
// //                   showCustomSnackBar("গন্তব্যস্থান প্রয়োজন", icon: Icons.info);
// //                 }
// //               }else{
// //                 showCustomSnackBar("সময় পর্যন্ত প্রয়োজন", icon: Icons.info);
// //               }
// //             }else{
// //               showCustomSnackBar("সময় থেকে প্রয়োজন", icon: Icons.info);
// //             }
// //           }else{
// //             showCustomSnackBar("আবেদনের তারিখ প্রয়োজন", icon: Icons.info);
// //           }
// //         }else{
// //           showCustomSnackBar("ব্যবহারের তারিখ প্রয়োজন", icon: Icons.info);
// //         }
// //       }else{
// //         showCustomSnackBar("আবেদনের প্রকারভেদ প্রয়োজন", icon: Icons.info);
// //       }
// //     }
// // ),
