import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import 'global_text.dart';

// class GlobalAppbarWidget extends StatelessWidget {
//   final String title;
//   final List<Widget>? action;
//   const GlobalAppbarWidget({
//     super.key,
//     required this.title,
//     this.action,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 30, bottom: 10),
//       color: ColorRes.black.withOpacity(0.5),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: (){
//               Get.back();
//             },
//             child: Container(
//               color: Colors.transparent,
//               height: 40,
//               width: 30,
//               child: const Center(
//                 child: Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                   color: ColorRes.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),
//           sizedBoxW(5),
//           Expanded(
//             child: GlobalText(
//               str: title,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           action?.isNotEmpty ?? false ? Row(
//             children: action ?? [],
//           ) : const SizedBox.shrink()
//         ],
//       ),
//     );
//   }
// }


class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({
    super.key,
    this.title,
    this.str,
    this.centerTitle,
    this.leading,
    this.backgroundColor,
    this.actions,
  });

  final Widget? title;
  final String? str;
  final Color? backgroundColor;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? ColorRes.primaryColor,
      automaticallyImplyLeading: false,
      leading: leading ?? IconButton(
        splashRadius: 0.1,
        icon: const Icon(Icons.arrow_back, color: ColorRes.white, size: 22),
        onPressed: (){
          Get.back();
        },
      ),
      centerTitle: centerTitle,
      title: title ?? GlobalText(
        str: str ?? '',
        color: ColorRes.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
        fontFamily: 'Rubik',
      ),
      actions: actions
    );
  }
}
