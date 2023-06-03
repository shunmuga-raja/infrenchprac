import 'package:flutter/material.dart';
import 'package:infrenchprac/login_screen.dart';
import 'package:infrenchprac/main_pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
 
  void tooglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(
        onTap: tooglePage, verificationId: 'verificationId',
      );
    }else{
      return RegisterPage(
        onTap: tooglePage,
        verificationId: 'verificationId',
      );
    }
  }
}