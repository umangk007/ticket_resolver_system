import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resolver_system/screens/homepage_screen.dart';
import 'package:ticket_resolver_system/screens/login_screen.dart';
import 'package:ticket_resolver_system/screens/reset_password_screen.dart';
import 'package:ticket_resolver_system/widgets/stored_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => checkLogin(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );
  }

  void checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserJson = prefs.getString(StoredData.userKey);
    if(storedUserJson != null) {
      var jsonUser = jsonDecode(storedUserJson);
      bool isFirst = jsonUser[StoredData.isFirstTimeKey];
      bool hasToken = prefs.containsKey(StoredData.tokenKey);
      if(isFirst == false && hasToken == true && context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
      } else if(isFirst == true && hasToken == true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen(),));
      }
    } else if(context.mounted) {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
   }

  }

}
