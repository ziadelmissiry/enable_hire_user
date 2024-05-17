import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final Color? color;
  final double height;

  const MyDivider({
    super.key,
    this.color,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.black.withOpacity(0.3),
      height: height,
    );
  }
}
