import 'package:enable_hire_user/features/auth/models/user_model.dart';
import 'package:enable_hire_user/features/auth/view/recruiter_create_company.dart';
import 'package:enable_hire_user/features/bottom_nav/view/bottom_nav_screen.dart';
import 'package:enable_hire_user/features/profile/modals/resume_modal.dart';
import 'package:enable_hire_user/features/profile/view/create_resume_screen.dart';
import 'package:enable_hire_user/features/profile/view/profile_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/bottom_navigation_bar_recruiter/view/recruiter_bottom_navigation_bar.dart';
import 'package:enable_hire_user/utils/strings/firebase_strings.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:enable_hire_user/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepo{

  void loginRepo({required email, required password, required WidgetRef ref,required BuildContext context, required String userType})async{

    try{

      SharedPreferences preferences = await SharedPreferences.getInstance();

      ref.read(isLoadingProvider.notifier).state= true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      var data = await  FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).get();

      bool hasResume = data.data()?['hasResume'] ?? false;
      bool isRecruiter = data.data()?['isRecruiter'] ?? false;

      if(data.data()?['userType'] ==Strings.userTypeRecruiter){
        Navigator.push(context, MaterialPageRoute(builder: (context){

          preferences.setBool(Strings.userTypeRecruiter, true);




          return isRecruiter? RecruiterNavScreen() : CreateCompanyScreen();
        }));
        ref.read(isLoadingProvider.notifier).state= false;
        return;
      }



      ref.read(isLoadingProvider.notifier).state= false;


      if(!hasResume){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CreateResumeScreen();
        }));



     }
     else{
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return BottomNavScreen();
        }));

     }

    }catch(e){
      ref.read(isLoadingProvider.notifier).state= false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));


    }





  }

  void signUpUserRepo({required String email, required String password, required WidgetRef ref, required String userName, required BuildContext context,required String profilePic, required String userType}) async{



    try{
      ref.read(isLoadingProvider.notifier).state= true;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      UserModal user = UserModal(userName: userName, email: email, password: password, hasResume: false, profilePic: profilePic, uid: FirebaseAuth.instance.currentUser!.uid, isRecruiter: false, userType: userType);


      await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).set(
        user.toMap()
      );

     await FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
     await FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePic);

      ref.read(isLoadingProvider.notifier).state= false;

      if(userType==Strings.userTypeRecruiter){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CreateCompanyScreen();
        }));
        ref.read(isLoadingProvider.notifier).state= false;
        return;
      }




      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return CreateResumeScreen();
      }));


    }
    catch(e){
      ref.read(isLoadingProvider.notifier).state= false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void saveResumeToFireStore({required String name, required String desiredPosition, required String contactNumber, required String email, required List<Map<String,String>>  companies,required List<String> hobbies,required List<String> skills, required experience, required List<Map<String,dynamic>> educationList, required BuildContext context, required WidgetRef ref })async{
    var firebaseFirestore = FirebaseFirestore.instance;
    var firebaseAuth = FirebaseAuth.instance;

    try{
      ref.read(isLoadingProvider.notifier).state= true;

      Resume resume = Resume(name: name, desiredPosition: desiredPosition, contactNumber: contactNumber, email: email, companies: companies, hobbies: hobbies, skills: skills, experience: experience, educationList: educationList, profilePic: FirebaseAuth.instance.currentUser!.photoURL!??'');

      await firebaseFirestore.collection(FirebaseStrings.usersCollection).doc(firebaseAuth.currentUser!.uid).collection(FirebaseStrings.resumeCollection).doc(firebaseAuth.currentUser!.uid).set(resume.toMap());
      firebaseFirestore.collection(FirebaseStrings.usersCollection).doc(firebaseAuth.currentUser!.uid).update({
        'hasResume':true,
      });
      ref.read(isLoadingProvider.notifier).state= false;

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const BottomNavScreen();
      }));



      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      //   return BottomNavScreen();
      // }), (route) => false);



    }
    catch(e){
      ref.read(isLoadingProvider.notifier).state= false;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

  }


  void logout(BuildContext context)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

   await FirebaseAuth.instance.signOut();

   await preferences.setBool(Strings.userTypeRecruiter, false);
   await preferences.setBool(Strings.userTypeUser, false);
   context.go('/${Routes.login}');
  }



  void editUserRepo({required String email, required WidgetRef ref, required String userName, required BuildContext context,required String profilePic}) async{



    try{
      ref.read(isLoadingProvider.notifier).state= true;

      // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      // UserModal user = UserModal(userName: userName, email: email, password: password, hasResume: false, profilePic: profilePic, uid: FirebaseAuth.instance.currentUser!.uid, isRecruiter: false, userType: userType);


      await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).update(
        {
          'userName':userName,
          'email':email,
          'profilePic':profilePic
        }
      );

      await FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePic);
      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);

      ref.read(isLoadingProvider.notifier).state= false;
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated Successfully')));



    }
    catch(e){
      ref.read(isLoadingProvider.notifier).state= false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }



}