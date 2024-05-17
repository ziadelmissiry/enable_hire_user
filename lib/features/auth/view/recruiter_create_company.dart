import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/bottom_navigation_bar_recruiter/view/recruiter_bottom_navigation_bar.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/firebase_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:enable_hire_user/utils/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCompanyScreen extends ConsumerStatefulWidget {
  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends ConsumerState<CreateCompanyScreen> {
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyDescriptionController = TextEditingController();
  File? _selectedImage;
  String imageUrl = '';

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<String> uploadAndGetUrl(String logoFilePath) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Reference storageRef = FirebaseStorage.instance.ref().child('logos/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(File(logoFilePath));

      final TaskSnapshot snapshot = await uploadTask;
      final String logoUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _isLoading = false;
      });

      return logoUrl;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return "";
    }
  }

  String image = '';

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    String imageUrl1 = await uploadAndGetUrl(pickedImage!.path);

    setState(() {
      _selectedImage = File(pickedImage.path);
      imageUrl = imageUrl1;
    });
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _validateInputs() {
    if (_selectedImage == null) {
      _showErrorMessage('Please select a Company Logo');
      return false;
    }
    if (_companyNameController.text.isEmpty) {
      _showErrorMessage('Please enter the Company Name');
      return false;
    }
    if (_companyDescriptionController.text.isEmpty) {
      _showErrorMessage('Please enter the Company Description');
      return false;
    }
    return true;
  }

  void _submitForm() async {
    if (!_validateInputs()) return;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });

    // Save data to Firestore
    await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection(FirebaseStrings.companiesCollection).doc(FirebaseAuth.instance.currentUser!.uid).set({
      'companyName': _companyNameController.text,
      'companyDescription': _companyDescriptionController.text,
      'companyLogo': imageUrl, // Save image path
    });
    await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).update({
      'isRecruiter': true,
    });

    setState(() {
      _isLoading = false;
    });

    preferences.setBool(Strings.userTypeRecruiter, true);

    // Navigate to recruiter navigation screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RecruiterNavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Company'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company Logo',
                style: Styles.largeBoldText(context, ref),
              ),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _selectedImage == null
                      ? Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                  )
                      : Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Company Name',
                style: Styles.largeBoldText(context, ref),
              ),
              Gap(10),
              MyTextField(
                controller: _companyNameController,
                hintText: 'Enter Company Name',
              ),
              SizedBox(height: 20.0),
              Text(
                'Company Description',
                style: Styles.largeBoldText(context, ref),
              ),
              Gap(10),
              MyTextField(
                controller: _companyDescriptionController,
                hintText: 'Enter Company Description',
                maxLines: 5,
              ),
              SizedBox(height: 20.0),
              MyCustomButton(
                onPressed: _submitForm,
                label: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
