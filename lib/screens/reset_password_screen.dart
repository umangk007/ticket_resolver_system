import 'package:flutter/material.dart';
import 'package:ticket_resolver_system/screens/homepage_screen.dart';
import 'package:ticket_resolver_system/screens/login_screen.dart';
import 'package:ticket_resolver_system/widgets/constant.dart';

import '../helper/screen_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool showRepeatPassword = false;
  bool showNewPassword = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController newpassController = TextEditingController();
  TextEditingController repeatpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth(context),
                    height: screenHeight(context, dividedBy: 3.5),
                    alignment: Alignment.center,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Image.asset("assets/images/logo.jpg"),
                  ),
                  const Text("New Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  TextFormField(
                    controller: newpassController,
                    obscureText: !showNewPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter new password",
                      suffixIcon: (showNewPassword)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  showNewPassword = !showNewPassword;
                                });
                              },
                              icon: const Icon(Icons.visibility_sharp))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showNewPassword = !showNewPassword;
                                });
                              },
                              icon: const Icon(Icons.visibility_off_sharp)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 18),
                  ),
                  const Text("Repeat Password",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  TextFormField(
                    controller: repeatpassController,
                    obscureText: !showRepeatPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter new password again",
                      suffixIcon: (showRepeatPassword)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  showRepeatPassword = !showRepeatPassword;
                                });
                              },
                              icon: const Icon(Icons.visibility_sharp))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showRepeatPassword = !showRepeatPassword;
                                });
                              },
                              icon: const Icon(Icons.visibility_off_sharp),
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    alignment: Alignment.centerRight,
                    child: const Text("Forget password ?",
                        style: TextStyle(
                          fontSize: 15,
                          color: green,
                        )),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 12),
                  ),
                  CommenButton(
                    text: "Reset",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    newpassController.dispose();
    repeatpassController.dispose();
    super.dispose();
  }
}
