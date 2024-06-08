// // // custom_progress_bar.dart
// // import 'package:flutter/material.dart';
// // import 'package:primer_progress_bar/primer_progress_bar.dart';

// // class CustomProgressBar extends StatelessWidget {
// //   final List<Segment> segments;
// //   final int displaySegmentCount;
// //   final bool alwaysFillBar;
// //   final bool limitLegendLines;

// //   const CustomProgressBar({
// //     Key? key,
// //     required this.segments,
// //     required this.displaySegmentCount,
// //     required this.alwaysFillBar,
// //     required this.limitLegendLines,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final maxTotalValue = segments.fold(0, (acc, seg) => acc + seg.value);

// //     return PrimerProgressBar(
// //       segments: segments.take(displaySegmentCount).toList(),
// //       maxTotalValue: alwaysFillBar ? null : maxTotalValue,
// //       legendStyle: limitLegendLines
// //           ? const SegmentedBarLegendStyle(maxLines: 2)
// //           : const SegmentedBarLegendStyle(maxLines: null),
// //       legendEllipsisBuilder: (truncatedItemCount) {
// //         final value = segments
// //             .skip(displaySegmentCount - truncatedItemCount)
// //             .take(truncatedItemCount)
// //             .fold(0, (accValue, segment) => accValue + segment.value);
// //         return LegendItem(
// //           segment: Segment(
// //             value: value,
// //             color: Colors.grey,
// //             label: const Text("Other"),
// //             valueLabel: Text("$value%"),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// // custom_progress_bar.dart
// import 'package:flutter/material.dart';
// import 'package:primer_progress_bar/primer_progress_bar.dart';

// class CustomProgressBarWidget extends StatefulWidget {
//   final List<Segment> segments;

//   const CustomProgressBarWidget({
//     Key? key,
//     required this.segments,
//   }) : super(key: key);

//   @override
//   _CustomProgressBarWidgetState createState() =>
//       _CustomProgressBarWidgetState();
// }

// class _CustomProgressBarWidgetState extends State<CustomProgressBarWidget> {
//   late int displaySegmentCount = widget.segments.length ~/ 2;
//   late double sliderValue = widget.segments.length / 2;
//   bool alwaysFillBar = false;
//   bool limitLegendLines = false;

//   @override
//   Widget build(BuildContext context) {
//     final maxTotalValue =
//         widget.segments.fold(0, (acc, seg) => acc + seg.value);

//     final options = [
//       SwitchListTile(
//         title: const Text("Always fill the entire bar"),
//         value: alwaysFillBar,
//         onChanged: (turnedOn) {
//           setState(() => alwaysFillBar = turnedOn);
//         },
//       ),
//       SwitchListTile(
//         title: const Text("Limit the legend lines"),
//         value: limitLegendLines,
//         onChanged: (turnedOn) {
//           setState(() => limitLegendLines = turnedOn);
//         },
//       ),
//     ];

//     final slider = SizedBox(
//       height: 56,
//       child: Slider(
//         value: sliderValue,
//         min: 0,
//         max: widget.segments.length.toDouble(),
//         divisions: widget.segments.length,
//         label: "$displaySegmentCount segment(s)",
//         onChanged: (value) {
//           setState(() {
//             sliderValue = value;
//             displaySegmentCount = value.round();
//           });
//         },
//       ),
//     );

//     return Column(
//       children: [
//         PrimerProgressBar(
//           segments: widget.segments.take(displaySegmentCount).toList(),
//           maxTotalValue: alwaysFillBar ? null : maxTotalValue,
//           legendStyle: limitLegendLines
//               ? const SegmentedBarLegendStyle(maxLines: 2)
//               : const SegmentedBarLegendStyle(maxLines: null),
//           legendEllipsisBuilder: (truncatedItemCount) {
//             final value = widget.segments
//                 .skip(displaySegmentCount - truncatedItemCount)
//                 .take(truncatedItemCount)
//                 .fold(0, (accValue, segment) => accValue + segment.value);
//             return LegendItem(
//               segment: Segment(
//                 value: value,
//                 color: Colors.grey,
//                 label: const Text("Other"),
//                 valueLabel: Text("$value%"),
//               ),
//             );
//           },
//         ),
//         ...options,
//         slider,
//       ],
//     );
//   }
// }
