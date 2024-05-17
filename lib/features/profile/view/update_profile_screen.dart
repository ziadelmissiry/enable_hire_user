import 'dart:io';

import 'package:enable_hire_user/features/auth/repositry/auth_repo.dart';
import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:enable_hire_user/utils/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/utils.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  EditProfileScreen({Key? key,});





  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<EditProfileScreen> {

  @override
  void initState() {
    userNameController.text = auth1.currentUser!.displayName ?? '';
    emailController.text = auth1.currentUser!.email ?? '';
    // TODO: implement initState
    super.initState();
  }
  FirebaseAuth auth1 = FirebaseAuth.instance;
  dynamic _selectedImage;
  File? image1;
  String imageUrl = '';
  String imageUr = '';

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();





  String selectedUserType = 'Employee'; // Default userType

  @override

  Widget build(BuildContext context) {




    imageUrl =  auth1.currentUser!.photoURL ?? '';
    void pickImage() async {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage =
      await imagePicker.pickImage(source: ImageSource.gallery);

      String imageUrl1 = await uploadAndGetUrl(pickedImage!.path);

      setState(() {
        image1 = File(pickedImage.path);
        imageUrl = imageUrl1;
        imageUr= imageUrl1;
      });
    }

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ModalProgressHUD(
          inAsyncCall: ref.watch(isLoadingProvider),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Enable Hire'.toUpperCase(),
                  style: Styles.largeText(context, ref).copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Styles.primary,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Styles.whiteColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: imageUr == ''
                              ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 140,
                            width: 140,
                          )
                              : Image.network(
                            imageUr,
                            fit: BoxFit.cover,
                            height: 140,
                            width: 140,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  MyTextField(controller: userNameController, hintText: "User Name"),
                  const Gap(10),
                  MyTextField(controller: emailController, hintText: "Email",readOnly: true,),

                ],
              ),
              MyCustomButton(
                onPressed: () {
                  AuthRepo().editUserRepo(email: emailController.text, ref: ref, userName: userNameController.text, context: context, profilePic: imageUr==''?imageUrl:imageUr);
                  // AuthRepo().signUpUserRepo(
                  //   email: emailController.text,
                  //   password: passwordController.text,
                  //   ref: ref,
                  //   userName: userNameController.text,
                  //   context: context,
                  //   profilePic: imageUrl,
                  //   userType: selectedUserType, // Pass selected userType
                  // );
                },
                label: "Save Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadAndGetUrl(String logoFilePath) async {

    try {

      ref.read(isLoadingProvider.notifier).state = true;

      final Reference storageRef =
      FirebaseStorage.instance.ref().child('logos/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(File(logoFilePath));

      final TaskSnapshot snapshot = await uploadTask;
      final String logoUrl = await snapshot.ref.getDownloadURL();

      ref.read(isLoadingProvider.notifier).state = false;


      return logoUrl;
    } catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;
      print("Error uploading logo: $e");
      return "";
    }
  }
}
