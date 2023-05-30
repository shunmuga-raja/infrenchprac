
import 'package:flutter/material.dart';
import 'package:infrenchprac/app_other/app_colors.dart';
import 'package:infrenchprac/components/auth_provider.dart';
import 'package:infrenchprac/components/custom_textfield.dart';
import 'package:infrenchprac/components/user_model.dart';
import 'package:country_picker/country_picker.dart';
import 'package:infrenchprac/main_pages/auth_page.dart';
import 'package:infrenchprac/main_pages/home_page.dart';
import 'package:infrenchprac/responsive_widget/custom_button.dart';
import 'package:infrenchprac/responsive_widget/resp_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final String verificationId;
  const RegisterPage({super.key, required this.verificationId});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String? otpCode;
  bool isPasswordShown = true;
  bool isConfirmPasswordShown = true;
  bool isLoading = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

   Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

   @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
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
                      const SizedBox(height: 6.0),
                      //Name textfield
                       CustomTextField(
                                    hintText: 'enter name',
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.name,
                                    prefix: Icon(Icons.person),
                                    validate: (email) {
                                      if (email!.isEmpty || email.length < 3) {
                                        return 'enter correct name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 6.0),
                                  //phone textfield
                          const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.purple,
                  controller: phoneController,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 550,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              });
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: phoneController.text.length > 9
                        ? Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : null,
                  ),
                ),
                 const SizedBox(height: 6.0),
                  CustomButton(
                      text: "Get OTP", onPressed: () => sendPhoneNumber()),       
                      //otp textfield
                      const SizedBox(height: 6.0),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.purple.shade200,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),     
                      const SizedBox(height: 6.0),
                      //email textfield
                      CustomTextField(
                        hintText: 'enter email',
                        textInputAction: TextInputAction.next,
                        keyboardtype: TextInputType.emailAddress,
                        prefix: const Icon(Icons.person),
                        validate: (email) {
                          if (email!.isEmpty ||
                              email.length < 3 ||
                              !email.contains("@")) {
                            return 'enter correct email';
                          }
                        },
                      ),
                      
                       const SizedBox(height: 6.0),

                      //password textfield
                      CustomTextField(
                        hintText: 'enter password',
                        isPassword: isPasswordShown,
                        prefix: const Icon(Icons.vpn_key_rounded),
                        validate: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return 'enter correct password';
                          }
                          return null;
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
                      const SizedBox(height: 8.0),

                      //confirm password textfield
                      CustomTextField(
                        hintText: 'confirm password',
                        isPassword: isPasswordShown,
                        prefix: const Icon(Icons.vpn_key_rounded),
                        validate: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return 'enter correct password';
                          }
                          return null;
                        },
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordShown = !isConfirmPasswordShown;
                              });
                            },
                            icon: isConfirmPasswordShown
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                      ),

                      //signUp button
                      SizedBox(height: height * 0.05),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {  if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                                      storeData();  
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
                      

                      SizedBox(height: height * 0.015),
                      //register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74)),
                          ),
                          SizedBox(width: 5),
                          //GestureDetector(
                            //onTap: widget.onTap,
                            //child: const Text(
                             // 'Log In',
                              //style: TextStyle(
                                  //color: Colors.blue,
                                  //fontWeight: FontWeight.bold),
                            //),
                         // ),
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
    // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: phoneController.text.trim(),
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        
        onSuccess: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false),
      );
}
void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+$phoneNumber");
  }

    // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthPage()),
                  (route) => false);
            }
          },
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
}
