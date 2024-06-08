// custom_slider.dart
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
        onChanged: onChanged,
      ),
    );
  }
}
