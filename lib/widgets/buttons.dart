import 'package:any_animated_button/any_animated_button.dart';
import 'package:flutter/material.dart';

class genButton extends CustomAnyAnimatedButton {
  genButton({
    required this.onTap,
    required this.text,
    this.enabled = true,
    required this.width,
    required this.bloc,
  });

  @override
  final AnyAnimatedButtonBloc? bloc;
  final VoidCallback onTap;
  final String text;
  final bool enabled;
  final double? width;

  final BorderRadius _borderRadius = BorderRadius.circular(22.0);

  @override
  AnyAnimatedButtonParams get defaultParams => AnyAnimatedButtonParams(
        width: width,
        height: 56.0,
        decoration: BoxDecoration(
          color: enabled ? Colors.blue : Colors.grey,
          borderRadius: _borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: _borderRadius,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class textbtn extends TextButton {
  textbtn({
    required this.onTap,
    required this.text,
    required super.onPressed,
    required super.child,
  });
  @override
  final VoidCallback onTap;
  final String text;
}
