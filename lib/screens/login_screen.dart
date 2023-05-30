import 'package:flutter/material.dart';
import 'package:ticket_resolver_system/Repository/repository.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';
import 'package:ticket_resolver_system/screens/reset_password_screen.dart';
import 'package:ticket_resolver_system/widgets/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool usernameEmpty = true;
  bool showPassword = false;
  bool isDisabled = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      usernameFieldCheck();
    });
  }

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
                  const Text("Username",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: usernameController,
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
                      hintText: "Enter your Email or Mobile no..",
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                      suffixIcon: (usernameEmpty)
                          ? const Icon(Icons.person)
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  usernameController.clear();
                                });
                              },
                              icon: const Icon(Icons.cancel_sharp)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter username";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 18),
                  ),
                  const Text("Password",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !showPassword,
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
                      hintText: "Enter your Password..",
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                      suffixIcon: (showPassword)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: const Icon(Icons.visibility_sharp))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
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
                  Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    alignment: Alignment.centerRight,
                    child: const Text("Forget password",
                        style: TextStyle(
                          fontSize: 15,
                          color: green,
                        )),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 12),
                  ),
                  CommenButton(
                      text: "Login",
                      isDisabled: isDisabled,
                      onTap: () {
                        if(formkey.currentState!.validate()) {
                          Repository().userLogIn(usernameController.text,
                              passwordController.text, context);
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
    );
  }

  usernameFieldCheck() {
    if (usernameController.text.isEmpty) {
      setState(() {
        usernameEmpty = true;
      });
    } else {
      setState(() {
        usernameEmpty = false;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
