import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/screen_size.dart';
import '../widgets/constant.dart';

class MyProfileScreen extends StatefulWidget {
  String? profilePic;
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
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: widget.profilePic != null
                  ? CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(widget.profilePic!),
              )
                  : const Icon(
                Icons.person_sharp,
                size: 50,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "Name"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.firstName == null ? "-" : "${widget.firstName} ${widget.lastName}" ?? "-",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "Phone"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.phone == null ? "-" : widget.phone ?? "-",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "Email"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.email == null ? "-" : widget.email ?? "-",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "Address"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.address == null ? "-" : widget.address ?? "-",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "City"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.city == null ? "-" : widget.city ?? "-",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "State"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.state == null ? "-" : widget.state ?? "-",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "Date joined"),
                Expanded(
                  child: DiscriptiveText(
                    text: widget.dateJoined != null
                        ? DateFormat('MM/dd/yyyy h:mm a').format(
                            DateTime.tryParse(widget.dateJoined!)!.toLocal())
                        : "-",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
