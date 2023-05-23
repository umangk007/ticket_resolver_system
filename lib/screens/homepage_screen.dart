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

  static const String text = "B/S, Royal Square, Silver Business Point, 304, Angle Square, VIP Cir To Utran Rd, Surat, Gujarat 394105";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Active Ticket"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app_sharp))
      ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            const BigText(text: "Complain Info :"),
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 5),
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const SmallText(text: "Complain :"),
                      SizedBox(width: screenWidth(context, dividedBy: 50),),
                      const DiscriptiveText(text: "Somthing is not working",)
                    ],
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 80),),
                  Row(
                    children: [
                      const SmallText(text: "Time :"),
                      SizedBox(width: screenWidth(context, dividedBy: 50),),
                      const DiscriptiveText(text: "12:05 PM",)
                    ],
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 80),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmallText(text: "Assigned by :"),
                      SizedBox(width: screenWidth(context, dividedBy: 50),),
                      const DiscriptiveText(text: "Gulabdas broker",)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 25),),
            const BigText(text: "Party Info :"),
            Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 4),
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const SmallText(text: "Name :"),
                      SizedBox(width: screenWidth(context, dividedBy: 50),),
                      const DiscriptiveText(text: "Mahadevbhai desai",)
                    ],
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 80),),
                  Row(
                    children: [
                      const SmallText(text: "Phone :"),
                      SizedBox(width: screenWidth(context, dividedBy: 50),),
                      const DiscriptiveText(text: "+919522315635",)
                    ],
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 80),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmallText(text: "Address :"),
                      SizedBox(width: screenWidth(context, dividedBy: 50),),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 1.5),
                        height: screenHeight(context, dividedBy: 7.5),
                        child: const DiscriptiveText(text: text, maxline: 4),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 20),),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportFormScreen(),));
              },
              child: Container(
                height: screenHeight(context, dividedBy: 17),
                width: screenWidth(context, dividedBy: 3.5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(),
                    color: const Color.fromARGB(255, 0, 191, 208)),
                child: const Text("Start",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}





