import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infrenchprac/login_screen.dart';
import 'package:infrenchprac/main_pages/home_page.dart';
import 'package:infrenchprac/main_pages/login_or_registerpage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
         if(snapshot.hasData){
          return  const HomePage();
         }
         else{
          return const LoginOrRegisterPage();
         }
        }
      ),
    );
  }
}