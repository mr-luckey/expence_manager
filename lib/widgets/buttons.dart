import 'package:any_animated_button/any_animated_button.dart';
import 'package:expence_manager/Components/theme/btnTheme.dart';
import 'package:expence_manager/Controllers/colorscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// class genButton extends CustomAnyAnimatedButton {
//   genButton({
//     required this.onTap,
//     required this.text,
//     this.enabled = true,
//     required this.width,
//     required this.bloc,
//     this.isdark,
//   });

//   @override
//   final AnyAnimatedButtonBloc? bloc;
//   final VoidCallback onTap;
//   final String text;
//   final bool enabled;
//   final isdark;
//   final double? width;

//   final BorderRadius _borderRadius = BorderRadius.circular(22.0);

//   @override
//   AnyAnimatedButtonParams get defaultParams => AnyAnimatedButtonParams(

//         width: width,
//         height: 56.0,
//         decoration: BoxDecoration(

//           //   color: enabled ? Colors.blue : Colors.grey,
//           borderRadius: _borderRadius,
//         ),
//         child: Material(
//           //color: Colors.transparent,
//           child: InkWell(
//             onTap: enabled ? onTap : null,
//             borderRadius: _borderRadius,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     text,
//                     // style: const TextStyle(color: Colors.white),
//                     maxLines: 1,
//                     softWrap: false,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
// }

// class btns {
//   btns({
//     required this.onTap,
//     required this.iconData,
//     required this.text,

//     // required this.onPressed,
//     // required super.child,
//   });
//   @override
//   final VoidCallback onTap;
//   final String text;
//   final IconData iconData;

//   // @override
// //   Widget btn() {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         height: 100,
// //         width: 100,
// //         decoration: BoxDecoration(
// //           color: Colors.blue,
// //           borderRadius: BorderRadius.circular(22),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(
// //               iconData,
// //               color: Colors.white,
// //             ),
// //             Text(
// //               text,
// //               style: TextStyle(color: Colors.white),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// }

// class textbtn extends TextButton {
//   textbtn({
//     required this.onTap,
//     required this.text,
//     required super.onPressed,
//     required super.child,
//   });
//   @override
//   final VoidCallback onTap;
//   final String text;
// }
// import 'package:flutter/material.dart';

// class Btn extends StatelessWidget {
//   final VoidCallback onTap;
//   final String text;
//   final IconData iconData;

//   Btn({
//     required this.onTap,
//     required this.text,
//     required this.iconData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           height: Get.height * 0.05,
//           width: Get.width * 0.25,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(22),
//           ),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   iconData,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   text,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'button_controller.dart';

class Btn extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData iconData;
  final int index;
  final bool? isdark;

  Btn({
    required this.onTap,
    this.isdark,
    required this.text,
    required this.iconData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonController buttonController = Get.put(ButtonController());

    return Obx(() {
      bool isSelected = buttonController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () {
          buttonController.selectButton(index);
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Container(
              height: Get.height * 0.05,
              width: Get.width * 0.25,
              decoration: BoxDecoration(
                color: isdark == true ? Colors.white : Colors.blue.shade900.withOpacity(1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      color: isdark == true ? Colors.blue.shade900 : Colors.white,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isdark == true ? Colors.blue.shade900 : Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

// import 'package:expence_manager/Components/theme/btnTheme.dart';
// import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final bool? isdark;
  final VoidCallback onPressed;
  final title ;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    this.isdark,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: isdark == true ? darkElevatedButton.style : lightElevatedButton.style,
      onPressed: onPressed,
      child: SizedBox(
        height: 25,
        width: Get.width / 2,
        child: Center(
          child: Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isdark == true ? Colors.black : Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

