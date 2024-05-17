import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/utils.dart';

class Styles {


  static Color primary = const Color.fromARGB(255, 0, 49, 83);
  // static Color primary = const Color.fromARGB(255, 75, 147, 101);
  static Color orangeColor = const Color.fromARGB(255, 231, 99, 43);
  static Color greenColor = Colors.green;
  // static Color backColor = const Color.fromARGB(255, 229, 240, 233);
  static Color backColor = const Color.fromARGB(255, 234, 237, 241);
  static Color blackColor = const Color.fromARGB(255, 0, 0, 0);
  static Color whiteColor = const Color.fromARGB(255, 255, 255, 255);

  // inverted colors
  static Color invertedPrimary = const Color.fromARGB(255, 255 - 0, 255 - 49, 255 - 83); // Inverted Primary
  static Color invertedOrangeColor = const Color.fromARGB(255, 255 - 231, 255 - 99, 255 - 43); // Inverted Orange
  static Color invertedGreenColor = const Color.fromARGB(255, 255 - 0, 255 - 255, 255 - 0); // Inverted Green
  static Color invertedBackColor = const Color.fromARGB(255, 255 - 234, 255 - 237, 255 - 241); // Inverted Back
  static Color invertedBlackColor = const Color.fromARGB(255, 255 - 0, 255 - 0, 255 - 0); // Inverted Black
  static Color invertedWhiteColor = const Color.fromARGB(255, 255 - 255, 255 - 255, 255 - 255);

  // Inverted White

  static Color highContrastPrimary = const Color.fromARGB(255, 255, 0, 0); // Red

// Orange High Contrast Color
  static Color highContrastOrangeColor = const Color.fromARGB(255, 255, 153, 0); // Orange

// Green High Contrast Color
  static Color highContrastGreenColor = const Color.fromARGB(255, 0, 255, 0); // Green

// Back High Contrast Color
  static Color highContrastBackColor = const Color.fromARGB(255, 0, 0, 255); // Blue

// Black High Contrast Color
  static Color highContrastBlackColor = const Color.fromARGB(255, 255, 255, 255); // White

// White High Contrast Color
  static Color highContrastWhiteColor = const Color.fromARGB(255, 0, 0, 0);




  static TextStyle largeText(BuildContext context, WidgetRef ref) {
    double textSize =   ref.watch(fontScaling);
    bool colorInversion = ref.watch(colorsInversion);

    bool boldColor = ref.watch(boldEnabled);
    bool contrastEnabled = ref.watch(colorsInversion);



    return TextStyle(
        color: colorInversion ?Styles.invertedBlackColor:contrastEnabled? Styles.highContrastBlackColor : Colors.black,

        fontSize: 25 * textSize,
        fontFamily: Strings.appFont,
        overflow: TextOverflow.ellipsis,
        fontWeight:boldColor?FontWeight.w900 : FontWeight.w400

    );

  }

  static TextStyle largeBoldText(BuildContext context,WidgetRef ref) {
    double textSize =   ref.watch(fontScaling);
    bool colorInversion = ref.watch(colorsInversion);
    bool boldColor = ref.watch(boldEnabled);
    bool contrastEnabled = ref.watch(colorsInversion);



    return TextStyle(
        color: colorInversion ?Styles.invertedBlackColor:contrastEnabled? Styles.highContrastBlackColor : Colors.black,
        fontSize: 25 * textSize,
        fontFamily: Strings.appFont,
        overflow: TextOverflow.ellipsis,
        fontWeight: boldColor?FontWeight.w900 : FontWeight.w600);
  }

  static TextStyle mediumText(BuildContext context,WidgetRef ref) {
    double textSize =   ref.watch(fontScaling);
    bool colorInversion = ref.watch(colorsInversion);
    bool boldColor = ref.watch(boldEnabled);
    bool contrastEnabled = ref.watch(colorsInversion);



    return TextStyle(
        color: colorInversion ?Styles.invertedBlackColor:contrastEnabled? Styles.highContrastBlackColor : Colors.black,

        fontSize: 16 * textSize,
        fontFamily: Strings.appFont,
        overflow: TextOverflow.ellipsis,
        fontWeight: boldColor?FontWeight.w900 : FontWeight.w400
    )

    ;
  }

  static TextStyle mediumBoldText(BuildContext context,WidgetRef ref) {
    double textSize =   ref.watch(fontScaling);
    bool colorInversion = ref.watch(colorsInversion);
    bool boldColor = ref.watch(boldEnabled);
    bool contrastEnabled = ref.watch(colorsInversion);


    return TextStyle(
        color: contrastEnabled ?Styles.invertedBlackColor:colorInversion? Styles.highContrastBlackColor : Colors.black,
        fontSize: 16 * textSize,
        overflow: TextOverflow.ellipsis,
        fontFamily: Strings.appFont,
        fontWeight: boldColor?FontWeight.w900 : FontWeight.w600
    );
  }

  static TextStyle smallBoldText(BuildContext context,WidgetRef ref) {
    double textSize =   ref.watch(fontScaling);
    bool colorInversion = ref.watch(colorsInversion);
    bool contrastEnabled = ref.watch(colorsInversion);
    bool boldColor = ref.watch(boldEnabled);


    return TextStyle(
        color: colorInversion ?Styles.invertedBlackColor:contrastEnabled? Styles.highContrastBlackColor : Colors.black,
        fontSize: 12 * textSize,
        overflow: TextOverflow.ellipsis,
        fontFamily: Strings.appFont,
        fontWeight: boldColor?FontWeight.w900 : FontWeight.w600
    );
  }

  static TextStyle smallText(BuildContext context,WidgetRef ref) {
    double textSize =   ref.watch(fontScaling);
    bool colorInversion = ref.watch(colorsInversion);
    bool boldColor = ref.watch(boldEnabled);
    bool contrastEnabled = ref.watch(colorsInversion);


    return TextStyle(
        color: colorInversion ?Styles.invertedBlackColor:contrastEnabled? Styles.highContrastBlackColor : Colors.black,

        fontSize: 12 * textSize,
        overflow: TextOverflow.ellipsis,
        fontFamily: Strings.appFont,
        fontWeight: boldColor?FontWeight.w900 : FontWeight.w400);
  }
}
