import 'package:enable_hire_user/routes/routes.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: myRoutes,
        title: 'Enable Hire',
        theme: ThemeData(scaffoldBackgroundColor:ref.watch(colorsInversion)?Styles.invertedBackColor : ref.watch(contrastEnabled)  ? Colors.black  :Styles.backColor,),
      );
    }
    );
  }
}
