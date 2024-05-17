import 'package:enable_hire_user/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class MyCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  Color? backgroundColor;
  Color? foregroundColor;
  double? width;
  Widget? icon;

  MyCustomButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.backgroundColor, // You can customize the default color
      this.foregroundColor, // You can customize the default color
      this.icon,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor ?? Styles.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(width ?? 100.w, 55),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: icon,
                  ),
            Flexible(
              child: Text(
                label,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  color: foregroundColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
