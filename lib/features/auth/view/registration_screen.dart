import 'dart:io';

import 'package:enable_hire_user/features/auth/repositry/auth_repo.dart';
import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/methods.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:enable_hire_user/utils/widgets/my_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/strings/strings.dart';
import '../../../utils/utils.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  RegistrationScreen({Key? key, required this.userType});

  final String userType;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<RegistrationScreen> {
  dynamic _selectedImage;
  File? image1;
  String imageUrl = '';

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedUserType = 'Employee'; // Default userType

  @override
  Widget build(BuildContext context) {
    void pickImage() async {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage =
      await imagePicker.pickImage(source: ImageSource.gallery);

      String imageUrl1 = await uploadAndGetUrl(pickedImage!.path);

      setState(() {
        image1 = File(pickedImage.path);
        imageUrl = imageUrl1;
      });
    }

    void _showErrorMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    bool _validateInputs() {
      if (userNameController.text.isEmpty) {
        _showErrorMessage('Please enter your User Name');
        return false;
      }
      if (emailController.text.isEmpty) {
        _showErrorMessage('Please enter your Email');
        return false;
      }
      if (passwordController.text.isEmpty) {
        _showErrorMessage('Please enter your Password');
        return false;
      }
      if (imageUrl.isEmpty) {
        _showErrorMessage('Please upload a Profile Picture');
        return false;
      }
      return true;
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
                  Text(
                    'Sign Up',
                    style: Styles.largeBoldText(context, ref).copyWith(fontSize: 35),
                  ),
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
                          child: image1 != null
                              ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 140,
                            width: 140,
                          )
                              : const Icon(Icons.person, size: 140),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  MyTextField(controller: userNameController, hintText: "User Name"),
                  const Gap(10),
                  MyTextField(controller: emailController, hintText: "Email"),
                  const Gap(10),
                  MyTextField(controller: passwordController, hintText: "Password"),
                  const Gap(10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Are you a?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedUserType,
                    items: <String>['Employee', 'Employer'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedUserType = newValue;
                        });
                      }
                    },
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Already have an Account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen(userType: selectedUserType)),
                          );
                        },
                        child: const Text('Log in'),
                      )
                    ],
                  ),
                ],
              ),
              MyCustomButton(
                onPressed: () {
                  if (_validateInputs()) {
                    AuthRepo().signUpUserRepo(
                      email: emailController.text,
                      password: passwordController.text,
                      ref: ref,
                      userName: userNameController.text,
                      context: context,
                      profilePic: imageUrl,
                      userType: selectedUserType, // Pass selected userType
                    );
                  }
                },
                label: "Sign Up",
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
