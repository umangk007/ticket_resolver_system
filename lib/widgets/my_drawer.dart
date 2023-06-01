import 'package:flutter/material.dart';
import 'package:ticket_resolver_system/widgets/constant.dart';

import '../helper/screen_size.dart';

class MyDrawer extends StatefulWidget {
  String? profilePic;
  String? firstName;
  String? lastName;

  MyDrawer({Key? key, this.profilePic, this.firstName, this.lastName})
      : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late bool hasProfile;

  @override
  void initState() {
    if (widget.profilePic == null) {
      hasProfile = true;
    } else {
      hasProfile = false;
    }
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
              height: screenHeight(context, dividedBy: 6),
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: hasProfile
                      ? Image.network(widget.profilePic!)
                      : const Icon(
                          Icons.person_sharp,
                          size: 50,
                          color: green,
                        )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              child: Text("${widget.firstName} ${widget.lastName}" ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Container(
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
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
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
