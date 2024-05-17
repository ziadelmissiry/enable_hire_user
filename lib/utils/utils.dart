
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);


final fontScaling = StateProvider<double>((ref) => 1);


final lineSpacing = StateProvider<double>((ref) => 1);


final contrastEnabled = StateProvider<bool>((ref) => false);


final colorsInversion = StateProvider<bool>((ref) => false);


final boldEnabled = StateProvider<bool>((ref) => false);

