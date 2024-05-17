import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/features/bottom_nav/view/bottom_nav_screen.dart';
import 'package:enable_hire_user/features/job/view/job_detail_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/bottom_navigation_bar_recruiter/view/recruiter_bottom_navigation_bar.dart';
import 'package:enable_hire_user/features/recruiter/features/recruiter_home_screen/view/applicant_details_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/list_of_jobs/view/applicant_list_screen.dart';
import 'package:enable_hire_user/features/recruiter/view/create_job.dart';
import 'package:enable_hire_user/features/splash/view/splash_screen.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:go_router/go_router.dart';

import '../features/recruiter/features/list_of_jobs/view/list_of_jobs.dart';

final GoRouter myRoutes = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) =>  const SplashScreen(),
    ),
    GoRoute(
      path: '/${Routes.login}',
      builder: (context, state) => LoginScreen(userType: 'user',),
    ),
    GoRoute(
        path: '/${Routes.bottomNav}',
        builder: (context, state) => const BottomNavScreen(),
        routes: [
          // GoRoute(
          //   // path: Routes.jobDetail,
          //   // builder: (context, state) => const JobDetailScreen(),
          // ),
        ]),
  ],
);



// it should are you recuiter or looking for the job,