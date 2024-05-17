import 'package:enable_hire_user/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MyHeader extends ConsumerWidget {
  final String text;
  final double dividerWidth;
  final double dividerHeight;
  final bool removeViewAll;
  Function()? onViewAllPressed;

  MyHeader({
    super.key,
    required this.text,
    this.dividerWidth = 5.0,
    this.dividerHeight = 20.0,
    this.removeViewAll = false,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          width: dividerWidth,
          height: dividerHeight,
          color: Theme.of(context).canvasColor.withOpacity(0.5),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Styles.mediumBoldText(context, ref),
        ),
        const Spacer(),
        removeViewAll
            ? const SizedBox()
            : TextButton(
                onPressed: onViewAllPressed,
                child: Text(
                  'View all',
                  style: Styles.smallBoldText(context, ref),
                ))
      ],
    );
  }
}
