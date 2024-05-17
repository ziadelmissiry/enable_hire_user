import 'dart:math';

import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  Color _randomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  List<String> categories = [
    'Paintings & Prints',
    'Photography',
    'Drawings & Illustration',
    'Digital Art',
    'Sculptures & Carvings',
    'Ceramics & Pottery',
    'Glass',
    'Jewelry',
    'Textile & Apparel',
    'Crafts & Other Art',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context: context, title: "Job Categories"),
        body: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(15),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: 10,
          itemBuilder: (context, index) {
            var cat = categories[index];
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _randomColor().withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                cat,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: Styles.mediumText(context,ref),
              ),
            );
          },
        ));
  }
}
