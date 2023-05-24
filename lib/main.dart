import 'package:flutter/material.dart';
import 'package:ticket_resolver_system/screens/login_screen.dart';
import 'package:ticket_resolver_system/screens/reset_password_screen.dart';
import 'package:ticket_resolver_system/widgets/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

