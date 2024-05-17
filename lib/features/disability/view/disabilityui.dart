import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';

class DisabilityFilterDialog extends ConsumerStatefulWidget {
  final Function(Map<String, dynamic>) onApply;

  const DisabilityFilterDialog({Key? key, required this.onApply}) : super(key: key);

  @override
  ConsumerState<DisabilityFilterDialog> createState() => _DisabilityFilterDialogState();
}

class _DisabilityFilterDialogState extends ConsumerState<DisabilityFilterDialog> {
  double textScaleFactor = 1.0; // Initial text scale
  bool highContrast = false;
  bool colorInversion = false;
  bool largerFontSize = false;
  bool voiceControl = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0, // Remove default shadow
      child: Container(
        padding: EdgeInsets.all(20.0), // Add padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Accessibility Filters',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0), // Add spacing
            Text('Text Size'),
            Slider(
              activeColor: Colors.blue, // Custom slider color
              thumbColor: Colors.green, // Use theme color
              value: ref.watch(fontScaling),
              min: 0.5,
              max: 1.3,
              divisions: 5,
              label: textScaleFactor.toStringAsFixed(1) + 'x',
              onChanged: (value) => setState(() {
                textScaleFactor = value;
                ref.read(fontScaling.notifier).state = value;

              }),
            ),
            Divider(), // Add divider for separation
            buildFilterRow(Icons.brightness_high, 'High Contrast', ref.read(contrastEnabled.notifier).state, (value) {

              ref.read(contrastEnabled.notifier).state = value!;

               ref.read(colorsInversion.notifier).state = false  ;


              setState(() {
                highContrast = value!;
              });
            }),
            buildFilterRow(Icons.invert_colors, 'Color Inversion', ref.read(colorsInversion.notifier).state, (value) {
              setState(() {
                ref.read(colorsInversion.notifier).state = value!;
                ref.read(contrastEnabled.notifier).state = false!;

                colorInversion=value!;
              });
            }),
            buildFilterRow(Icons.font_download, 'Bold Font', ref.read(boldEnabled.notifier).state, (value) {
              setState(() {
                ref.read(boldEnabled.notifier).state = value!;
              });
            }),
            // buildFilterRow(Icons.mic, 'Voice Control', voiceControl, (value) {
            //   setState(() {
            //     voiceControl = value!;
            //   });
            // }),
          ],
        ),
      ),
    );
  }

  Widget buildFilterRow(IconData icon, String title, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey), // Add icon
        SizedBox(width: 10.0),
        Text(title),
        Spacer(),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

void showDisabilityFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DisabilityFilterDialog(
        onApply: (filters) {
          // Handle applying filters here
          print(filters);
        },
      );
    },
  );
}
