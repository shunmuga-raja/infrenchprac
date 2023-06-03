import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:infrenchprac/app_other/app_colors.dart';
import 'package:infrenchprac/components/auth_provider.dart';
import 'package:infrenchprac/main_pages/home_page.dart';
import 'package:infrenchprac/main_pages/register_page.dart';
import 'package:infrenchprac/responsive_widget/custom_button.dart';
import 'package:infrenchprac/responsive_widget/resp_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String verificationId;
  const LoginScreen({super.key, required this.verificationId, required void Function() onTap});
  
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? otpCode;

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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backColor,
      resizeToAvoidBottomInset : false,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context)
                 ? const SizedBox()
                 :Expanded(
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
                      SafeArea(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                            child: Column(
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.shade50,
                                  ),
                                  child: Image.asset(
                                    "assets/image2.png",
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Add your phone number. We'll send you a verification code",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
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
                                const SizedBox(height: 20),
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
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: CustomButton(
                                      text: "Login", onPressed: () => sendPhoneNumber()),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: CustomButton(
                                      text: "next", onPressed: () {
                                            if (otpCode != null) {
                                              verifyOtp(context, otpCode!);
                                            } else {
                                              showSnackBar(context, "Enter 6-Digit code");
                                            }
                                          },),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
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
                      builder: (context) => RegisterPage(verificationId: '', onTap: () {  },)),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}