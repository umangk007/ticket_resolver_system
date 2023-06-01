import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/screen_size.dart';
import '../widgets/constant.dart';

class MyProfileScreen extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? state;
  String? dateJoined;

  MyProfileScreen(
      {Key? key,
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
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 6),
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Icon(
                    Icons.person_sharp,
                    size: 50,
                    color: green,
                  )),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            Row(
              children: [
                const SmallText(text: "Name"),
                DiscriptiveText(
                  text: "${widget.firstName} ${widget.lastName}" ?? "",
                )
              ],
            ),
            Row(
              children: [
                const SmallText(text: "Phone"),
                DiscriptiveText(
                  text: widget.phone ?? "",
                )
              ],
            ),
            Row(
              children: [
                const SmallText(text: "Email"),
                DiscriptiveText(
                  text: widget.email ?? "",
                )
              ],
            ),
            Row(
              children: [
                const SmallText(text: "Address"),
                DiscriptiveText(
                  text: widget.address ?? "",
                )
              ],
            ),
            Row(
              children: [
                const SmallText(text: "City"),
                DiscriptiveText(
                  text: widget.city ?? "",
                )
              ],
            ),
            Row(
              children: [
                const SmallText(text: "State"),
                DiscriptiveText(
                  text: widget.state ?? "",
                )
              ],
            ),
            Row(
              children: [
                const SmallText(text: "Date joined"),
                DiscriptiveText(
                  text: widget.dateJoined != null ? DateFormat('MM/dd/yyyy h:mm a')
                      .format(DateTime.tryParse(widget.dateJoined!)!.toLocal())
                      : "",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
