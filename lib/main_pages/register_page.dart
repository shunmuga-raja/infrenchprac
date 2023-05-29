import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrenchprac/app_other/app_colors.dart';
import 'package:infrenchprac/app_other/squaretile_field.dart';
import 'package:infrenchprac/components/custom_textfield.dart';
import 'package:infrenchprac/responsive_widget/resp_widget.dart';
import 'package:infrenchprac/services/auth_signin_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void signinUser() async {
    //show loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //wrong email
      showErrorMessage(e.code);
    }
  }

  //error msg
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context)
                ? const SizedBox()
                : Expanded(
                    child: Container(
                      height: height,
                      color: AppColors.mainBlueColor,
                      child: const Center(
                        child: Text(
                          'AdminPage',
                          style: TextStyle(
                            fontSize: 48.0,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(
                    horizontal: ResponsiveWidget.isSmallScreen(context)
                        ? height * 0.032
                        : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.2),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Let’s',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: AppColors.blueDarkColor,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.blueDarkColor,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      const Text(
                        'Hey, Enter your details to get sign Up \nto your account.',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: height * 0.064),

                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      //email textfield
                      CustomTextField(
                        controller: emailController,
                        hintText: 'enter email',
                        textInputAction: TextInputAction.next,
                        keyboardtype: TextInputType.emailAddress,
                        prefix: const Icon(Icons.person),
                        onsave: (email) {
                          _formData['email'] = email ?? "";
                        },
                        validate: (email) {
                          if (email!.isEmpty ||
                              email.length < 3 ||
                              !email.contains("@")) {
                            return 'enter correct email';
                          }
                        },
                      ),

                      //password headline
                      SizedBox(height: height * 0.019),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),

                      //password textfield
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'enter password',
                        isPassword: isPasswordShown,
                        prefix: const Icon(Icons.vpn_key_rounded),
                        validate: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return 'enter correct password';
                          }
                          return null;
                        },
                        onsave: (password) {
                          _formData['password'] = password ?? "";
                        },
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });
                            },
                            icon: isPasswordShown
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                      ),
                      SizedBox(height: height * 0.019),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      //confirm password textfield
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'confirm password',
                        isPassword: isPasswordShown,
                        prefix: const Icon(Icons.vpn_key_rounded),
                        validate: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return 'enter correct password';
                          }
                          return null;
                        },
                        onsave: (password) {
                          _formData['password'] = password ?? "";
                        },
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });
                            },
                            icon: isPasswordShown
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                      ),

                      //signin button
                      SizedBox(height: height * 0.05),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            signinUser;
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70.0, vertical: 18.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: AppColors.mainBlueColor,
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.030),

                      //or continue
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Color.fromARGB(255, 85, 81, 81),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 120.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      // google sign in buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(
                            onTap: () => AuthService().signInWithGoogle(),
                            imagePath: 'assets/Google_Logo.png',
                          ),

                          //apple signin
                          const SizedBox(width: 10),
                          SquareTile(
                            onTap: () {},
                            imagePath: 'assets/Apple_logo.png',
                          ),

                          //facebook signin
                          const SizedBox(width: 15),
                          SquareTile(
                            onTap: () {},
                            imagePath: 'assets/facebook_logo.png',
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.015),
                      //register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account',
                            style: TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74)),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}