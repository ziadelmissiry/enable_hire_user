import 'package:enable_hire_user/features/auth/repositry/auth_repo.dart';
import 'package:enable_hire_user/features/auth/view/registration_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:enable_hire_user/utils/widgets/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key, required this.userType});

  String userType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty) {
      _showErrorMessage('Please enter your Email');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showErrorMessage('Please enter your Password');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: ref.watch(isLoadingProvider),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                    'Log in',
                    style: Styles.largeBoldText(context, ref).copyWith(fontSize: 35),
                  ),
                  const Gap(10),
                  MyTextField(controller: emailController, hintText: "Email"),
                  const Gap(10),
                  MyTextField(controller: passwordController, hintText: "Password"),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Don't have an Account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RegistrationScreen(userType: widget.userType);
                          }));
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
              MyCustomButton(
                onPressed: () {
                  if (_validateInputs()) {
                    AuthRepo().loginRepo(
                      email: emailController.text,
                      password: passwordController.text,
                      ref: ref,
                      context: context,
                      userType: widget.userType,
                    );
                  }
                },
                label: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
