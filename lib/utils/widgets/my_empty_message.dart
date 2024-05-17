import 'package:enable_hire_user/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lottie/lottie.dart';

class EmptyStateMessage extends ConsumerWidget {
  final String message;
  final String animationAsset;

  const EmptyStateMessage({
    super.key,
    required this.message,
    required this.animationAsset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animationAsset, height: 20.h),
          Text(
            message,
            style: Styles.mediumText(context, ref)
                .copyWith(fontSize: 20, color: Colors.black.withOpacity(0.5)),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
