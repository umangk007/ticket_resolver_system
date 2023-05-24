import 'package:flutter/material.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';
import 'package:ticket_resolver_system/screens/report_form_screen.dart';

import '../widgets/constant.dart';
import '../widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String text =
      "B/S, Royal Square, Silver Business Point, 304, Angle Square, VIP Cir To Utran Rd, Surat, Gujarat 394105";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Ticket"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.exit_to_app_sharp))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BigText(text: "Complain Info"),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            const Row(
              children: [
                SmallText(text: "Complain "),
                DiscriptiveText(
                  text: "Something is not working",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            const Row(
              children: [
                SmallText(text: "Time "),
                DiscriptiveText(
                  text: "12:05 PM",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            const Row(
              children: [
                SmallText(text: "Assigned by"),
                DiscriptiveText(
                  text: "Gulabdas broker",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            const BigText(text: "Party Info"),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            const Row(
              children: [
                SmallText(text: "Name"),
                DiscriptiveText(
                  text: "Mahadevbhai desai",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            const Row(
              children: [
                SmallText(text: "Phone"),
                DiscriptiveText(
                  text: "+919522315635",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(text: "Address"),
                SizedBox(
                  width: screenWidth(context, dividedBy: 1.7),
                  height: screenHeight(context, dividedBy: 7.5),
                  child: const DiscriptiveText(text: text, maxline: 4),
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 20),
            ),
            CommenButton(
              text: "Start",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportFormScreen(),
                  )),
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
