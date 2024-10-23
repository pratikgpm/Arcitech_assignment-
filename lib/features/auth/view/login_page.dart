import 'package:arcitech/features/auth/services/firebase_auth_services.dart';
import 'package:arcitech/features/controller/userController.dart';
import 'package:arcitech/features/home/view/navigationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/customButton.dart';
import '../../../core/widgets/customField.dart';
import 'package:arcitech/features/auth/view/signup_page.dart';

class loginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const loginView(),
      );

  const loginView({super.key});

  @override
  _loginViewState createState() => _loginViewState();
}

class _loginViewState extends ConsumerState<loginView> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = ref.read(userProvider.notifier);
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
                  "Log In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Pallete.headingFontColr),
                ),
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
                      const SizedBox(height: 13),
                      Align(
                          alignment: Alignment.centerRight,
                          //ADD THE FORGOT PASSWORD FUNCTIONALITY
                          child: InkWell(
                            onTap: () {
                              print("working");
                            },
                            child: const Text(
                              "Forget password?",
                              style: TextStyle(
                                  color: Pallete.regFontColr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          )),
                      const SizedBox(
                        height: 13,
                      ),
                      customButton(
                        title: "Log In",
                        onPressed: sign,
                        //onPressed: _signin,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: 'Don’t have an account? ',
                              style: const TextStyle(
                                  color: Pallete.regFontColr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign up',
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
                                          context, signupView.route());
                                    },
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 0.5,
                            endIndent: 20,
                          )),
                          Text(
                            "Or login with",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              indent: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Center(
                        child: SizedBox(
                          height: 48,
                          width: 122,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset('assets/svg_files/google_.svg'),
                              SvgPicture.asset(
                                  'assets/svg_files/facebook_.svg'),
                            ],
                          ),
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

  void sign() async {
    String email = emailController.text;
    String password = passwordController.text;
    final user = ref.read(userProvider.notifier).signIn(email, password);
    if (user != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MyHomePage.route(),
        (route) => false,
      );
    } else {
      print("error");
    }
  }
}
