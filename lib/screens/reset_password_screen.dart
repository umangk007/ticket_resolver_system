import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticket_resolver_system/Repository/repository.dart';
import 'package:ticket_resolver_system/widgets/constant.dart';

import '../helper/screen_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isLoading = false;
  bool showRepeatPassword = false;
  bool showNewPassword = false;
  bool isDisabled = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController newpassController = TextEditingController();
  TextEditingController repeatpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              color: const Color.fromARGB(255, 255, 255, 255),
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
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: newpassController,
                      obscureText: !showNewPassword,
                      decoration: InputDecoration(
                        focusColor: green,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: green),
                            borderRadius: BorderRadius.circular(10)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: green),
                            borderRadius: BorderRadius.circular(10)),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 30),
                    ),
                    const Text("Repeat Password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: repeatpassController,
                      obscureText: !showRepeatPassword,
                      decoration: InputDecoration(
                        focusColor: green,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: green),
                            borderRadius: BorderRadius.circular(10)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: green),
                            borderRadius: BorderRadius.circular(10)),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 10),
                    ),
                    CommenButton(
                        text: "Reset",
                        isDisabled: isDisabled,
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            if (newpassController.text ==
                                repeatpassController.text) {
                              setState(() {
                                isLoading = true;
                              });
                              Repository().resetPassword(
                                  newpassController.text, context);
                              Timer(const Duration(seconds: 1), () {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            } else {
                              const SnackBar snackBar = SnackBar(
                                content:
                                    Text('Both the passwords are not same.'),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            setState(() {
                              isDisabled = true;
                            });
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading ? LoadingPage() : const SizedBox()
      ]),
    );
  }

  @override
  void dispose() {
    newpassController.dispose();
    repeatpassController.dispose();
    super.dispose();
  }
}
