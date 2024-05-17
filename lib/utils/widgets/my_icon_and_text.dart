import 'package:enable_hire_user/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyIconAndText extends ConsumerWidget {
  final String imagePath;
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final double fontSize;
  final VoidCallback? onTap;

  const MyIconAndText({
    super.key,
    required this.imagePath,
    required this.text,
    this.textColor,
    this.iconColor,
    this.fontSize = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Image.asset(
                imagePath,
                height: 30,
                width: 30,
                color: iconColor ?? Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: Styles.mediumText(context, ref)
                  .copyWith(color: textColor ?? Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
