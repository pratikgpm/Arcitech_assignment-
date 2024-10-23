import 'package:arcitech/features/controller/userController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/customButton.dart';
import '../../../core/widgets/customField.dart';
import 'package:arcitech/features/auth/view/login_page.dart';
import 'package:arcitech/features/auth/services/firebase_auth_services.dart';
import 'package:arcitech/core/widgets/common_widgets.dart';

class signupView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const signupView(),
      );

  const signupView({super.key});

  @override
  _signupViewState createState() => _signupViewState();
}

class _signupViewState extends ConsumerState<signupView> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bggrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 63,
            width: 249,
            margin: EdgeInsets.only(top: 86, left: 24),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Pallete.headingFontColr),
                ),
                Text(
                  "Enter your details below & free sign up",
                  style: TextStyle(
                      color: Color(0xffB8B8D2),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Pallete.whiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(20)),
              ),
              margin: const EdgeInsets.only(top: 10),
              width: double.maxFinite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Email",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Pallete.regFontColr),
                      ),
                      CustomFields.CustomFields(
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Pallete.regFontColr),
                      ),
                      CustomFields.CustomFields(
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      customButton(
                        title: "Creat account",
                        onPressed: signup,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        height: 36,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                              child: Checkbox(
                                activeColor: Pallete.bgBlue,
                                value: _isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isChecked = newValue!;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 36,
                              child: const Text(
                                "By creating an account you have to agre\nwith our them & condication.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Pallete.regFontColr),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: 'Already have an account? ',
                              style: const TextStyle(
                                  color: Pallete.regFontColr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Login',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle the login tap here.
                                      Navigator.push(
                                          context, loginView.route());
                                    },
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void signup() async {
    String email = emailController.text;
    String password = passwordController.text;
    final user = ref.read(userProvider.notifier).signUp(email, password);
    if (user != null) {
      commonWidgets.showSuccessDialog(context);
    } else {
      print("error");
    }
  }
}
