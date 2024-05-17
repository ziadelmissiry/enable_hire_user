import 'package:enable_hire_user/features/auth/repositry/auth_repo.dart';
import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/features/profile/view/change_password_screen.dart';
import 'package:enable_hire_user/features/profile/view/create_resume_screen.dart';
import 'package:enable_hire_user/features/profile/view/update_profile_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/recruiter_home_screen/view/applicant_details_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  bool currentUser = FirebaseAuth.instance.currentUser != null;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb?Column(
        children: [

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Styles.whiteColor,
                ),
                shape: BoxShape.circle),
            child: ClipOval(
                child: Image.network(
                  firebaseAuth.currentUser != null ? firebaseAuth.currentUser!.photoURL! : Strings.profileImage,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 140,
                )),
          ),
          Column(
            children: [
              Text(
                FirebaseAuth.instance.currentUser != null?  firebaseAuth.currentUser!.displayName! : 'Guest',
                style:
                Styles.mediumBoldText(context,ref).copyWith(fontSize: 20),
              ),
              Text(
                firebaseAuth.currentUser != null ?  firebaseAuth.currentUser!.email! :  "no email",
                style: Styles.smallText(context,ref).copyWith(
                  color: Styles.primary.withOpacity(0.5),
                  letterSpacing: 3,
                ),
              ),
              const Gap(20),
              if(currentUser)      InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ApplicantDetailsScreen(resumeId: FirebaseAuth.instance.currentUser!.uid);
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: Styles.blackColor.withOpacity(0.6),
                    ),
                  ),
                  child: Text(
                    'My Resume',
                    style: Styles.mediumBoldText(context,ref),
                  ),
                ),
              ),
              const Gap(20),
              if(currentUser)    InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return EditProfileScreen();
                  }));
                },
                child: profileWidget(
                    text: "Edit Profile",
                    iconWidget: Icon(
                      CupertinoIcons.person_alt,
                      color: Styles.whiteColor,
                    )
                ),
              ),
              const Gap(10),
              if(currentUser)      InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const ChangePasswordScreen();
                  }));
                },
                child: profileWidget(
                    text: "Change Password",
                    iconWidget: Icon(
                      CupertinoIcons.settings,
                      color: Styles.whiteColor,
                    )),
              ),
              const Gap(10),
              if(!currentUser)       profileWidget(
                  onTap: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginScreen(userType: Strings.userTypeUser);
                    }));

                  },
                  iconWidget: Icon(
                    Icons.login,
                    color: Styles.whiteColor,
                  ),
                  text: "Login",
                  backgroundColor: Styles.orangeColor),

              if(currentUser)       profileWidget(
                  onTap: () async{
                    AuthRepo().logout(context);

                  },
                  iconWidget: Icon(
                    Icons.logout,
                    color: Styles.whiteColor,
                  ),
                  text: "Logout",
                  backgroundColor: Styles.orangeColor),
            ],
          ),


        ],
      ) :  Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -50.w,
            right: 40.w,
            child: Container(
              width: 100.w,
              height: 130.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.orangeColor.withOpacity(0.3)),
            ),
          ),
          Positioned(
            top: -10.w,
            left: 70.w,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.primary.withOpacity(0.3)),
            ),
          ),
          Positioned(
            top: 50.w - 70,
            left: 50.w - 70 - 5,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    color: Styles.whiteColor,
                  ),
                  shape: BoxShape.circle),
              child: ClipOval(
                  child: Image.network(
               firebaseAuth.currentUser != null ? firebaseAuth.currentUser!.photoURL! : Strings.profileImage,
                fit: BoxFit.cover,
                height: 140,
                width: 140,
              )),
            ),
          ),
          Positioned(
            top: 50.w + 70 + 10,
            child: SizedBox(
              width: 100.w,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                    FirebaseAuth.instance.currentUser != null?  firebaseAuth.currentUser!.displayName! : 'Guest',
                      style:
                          Styles.mediumBoldText(context,ref).copyWith(fontSize: 20),
                    ),
                    Text(
                      firebaseAuth.currentUser != null ?  firebaseAuth.currentUser!.email! :  "no email",
                      style: Styles.smallText(context,ref).copyWith(
                        color: Styles.primary.withOpacity(0.5),
                        letterSpacing: 3,
                      ),
                    ),
                    const Gap(20),
              if(currentUser)      InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ApplicantDetailsScreen(resumeId: FirebaseAuth.instance.currentUser!.uid);
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Styles.blackColor.withOpacity(0.6),
                          ),
                        ),
                        child: Text(
                          'My Resume',
                          style: Styles.mediumBoldText(context,ref),
                        ),
                      ),
                    ),
                    const Gap(20),
                if(currentUser)    InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return EditProfileScreen();
                    }));
                  },
                  child: profileWidget(
                          text: "Edit Profile",
                          iconWidget: Icon(
                            CupertinoIcons.person_alt,
                            color: Styles.whiteColor,
                          )
                      ),
                ),
                    const Gap(10),
                    if(currentUser)      InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const ChangePasswordScreen();
                        }));
                      },
                      child: profileWidget(
                          text: "Change Password",
                          iconWidget: Icon(
                            CupertinoIcons.settings,
                            color: Styles.whiteColor,
                          )),
                    ),
                    const Gap(10),
                    if(!currentUser)       profileWidget(
                        onTap: () async{
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return LoginScreen(userType: Strings.userTypeUser);
                          }));

                        },
                        iconWidget: Icon(
                          Icons.login,
                          color: Styles.whiteColor,
                        ),
                        text: "Login",
                        backgroundColor: Styles.orangeColor),

                    if(currentUser)       profileWidget(
                        onTap: () async{
                          AuthRepo().logout(context);

                        },
                        iconWidget: Icon(
                          Icons.logout,
                          color: Styles.whiteColor,
                        ),
                        text: "Logout",
                        backgroundColor: Styles.orangeColor),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profileWidget(
      {required String text,
      Color? backgroundColor,
      Widget? iconWidget,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: backgroundColor ?? Styles.primary,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            iconWidget ?? const SizedBox(),
            iconWidget != null ? const Gap(15) : const SizedBox(),
            Text(
              text,
              style:
                  Styles.mediumText(context,ref).copyWith(color: Styles.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
