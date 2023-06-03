import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resolver_system/screens/my_profile_screen.dart';
import 'package:ticket_resolver_system/widgets/constant.dart';

import '../helper/screen_size.dart';
import '../screens/login_screen.dart';

class MyDrawer extends StatefulWidget {
  String? profilePic;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? state;
  String? dateJoined;

  MyDrawer(
      {Key? key,
      this.profilePic,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.address,
      this.city,
      this.state,
      this.dateJoined})
      : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: screenWidth(context, dividedBy: 1.5),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 8),
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: widget.profilePic != "null"
                  ? ClipOval(
                      child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(widget.profilePic!),
                    ))
                  : const Icon(
                      Icons.person_sharp,
                      size: 50,
                      color: Colors.green,
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              child: Text("${widget.firstName} ${widget.lastName}" ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfileScreen(
                      profilePic: widget.profilePic,
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      phone: widget.phone,
                      email: widget.email,
                      address: widget.address,
                      city: widget.city,
                      state: widget.state,
                      dateJoined: widget.dateJoined,
                    ),
                  )),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.person,
                        color: green,
                      ),
                    ),
                    Text(
                      'My Profile',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                  await prefs.clear();
                }
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.exit_to_app_sharp,
                        color: green,
                      ),
                    ),
                    Text(
                      'Logout',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20),
              child:
                  Text("V1.0.2", style: TextStyle(color: Colors.grey.shade700)),
            )
          ],
        ),
      ),
    );
  }
}
