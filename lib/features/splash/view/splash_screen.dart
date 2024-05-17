import 'dart:async';

import 'package:enable_hire_user/features/bottom_nav/view/bottom_nav_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/bottom_navigation_bar_recruiter/view/recruiter_bottom_navigation_bar.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  checkPost() {
    Timer(const Duration(seconds: 4), () async{
      SharedPreferences preferences = await SharedPreferences.getInstance();

    bool isRecruiter =   preferences.getBool(Strings.userTypeRecruiter) ?? false;
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connectivity Error, E/flutter (12345): [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: [cloud_firestore/unavailable] Failed to get document because the client is offline.'),backgroundColor: Colors.red,));


   isRecruiter?  Navigator.push(context, MaterialPageRoute(builder: (context){
     return const RecruiterNavScreen();
   }))   : Navigator.push(context, MaterialPageRoute(builder: (context){
     return const BottomNavScreen();
   })) ;

    });
  }

  @override
  void initState() {
    super.initState();
    checkPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(100),
            const Spacer(),
            Text(
              'Enable Hire'.toUpperCase(),
              style: Styles.largeText(context,ref).copyWith(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Styles.primary,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text(
                '[SPLASH SCREEN]',
                style: Styles.smallBoldText(context,ref)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
