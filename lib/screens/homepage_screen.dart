import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resolver_system/Repository/repository.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';
import 'package:ticket_resolver_system/models/ticket_model.dart';
import 'package:ticket_resolver_system/screens/login_screen.dart';
import 'package:ticket_resolver_system/screens/report_form_screen.dart';

import '../models/profile_model.dart';
import '../widgets/constant.dart';
import '../widgets/my_drawer.dart';
import '../widgets/stored_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Result> activeTicket = [];
  var profileDataList;
   late bool isLoading;
   late String ticketStatus;
  static const baseURL =
      "http://ticket-resolver-flyontech-env.eba-jzpfeppv.us-east-2.elasticbeanstalk.com";

  @override
  void initState() {
    super.initState();
    getProfile();
    getTicketData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Ticket"),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if(context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                 await prefs.clear();
                }
                },
              icon: const Icon(Icons.exit_to_app_sharp))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 5),
        child: isLoading ? const Center(
          child: CircularProgressIndicator(),
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BigText(text: "Complain Info"),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            Row(
              children: [
                const SmallText(text: "Complain "),
                DiscriptiveText(
                    text: activeTicket[0].customComplain ??
                        activeTicket[0].complain?.complain
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            Row(
              children: [
                const SmallText(text: "Time "),
                DiscriptiveText(
                  text: activeTicket[0].time?.toLocal().toString() ?? "",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            Row(
              children: [
                const SmallText(text: "Assigned by"),
                DiscriptiveText(
                  text:
                  "${activeTicket[0].callRecivedBy?.firstName} ${activeTicket[0]
                      .callRecivedBy?.lastName}" ??
                      "",
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
            Row(
              children: [
                const SmallText(text: "Name"),
                DiscriptiveText(
                  text:
                  activeTicket[0].party?.name ??
                      "",
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 80),
            ),
            Row(
              children: [
                const SmallText(text: "Phone"),
                DiscriptiveText(
                  text: activeTicket[0].party?.mobileNo ?? "",
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
                  child: DiscriptiveText(
                      text: activeTicket[0].party?.address ?? "",
                      maxline: 4),
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 20),
            ),
            CommenButton(
                text: ticketStatus,
                onTap: () async{
                if(activeTicket[0].status == "ALLOCATION_COMPLETE") {
                  startTicket();
                } else if(activeTicket[0].status == "ONSITE") {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportFormScreen()));
                }
                }
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  void getTicketData() async {
    try {
      isLoading = true;
      TicketModel? ticketData = await Repository().getData();
      if (ticketData?.results != null) {
        setState(() {
          activeTicket.addAll(ticketData?.results as Iterable<Result>);
          isLoading = false;
        });
        if (activeTicket[0].status == "ALLOCATION_COMPLETE") {
          ticketStatus = "Start";
        } else if (activeTicket[0].status == "ONSITE") {
          ticketStatus = "Mark As Complete";
        }
      }
    } catch (e) {
       isLoading = true;
      log(e.toString());
    }
  }

  Future startTicket() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = activeTicket[0].id;
      var url = "$baseURL/api/start_ticket/$id/";
      var data = {
        "status" : "ONSITE",
      };
      String? token = prefs.getString(StoredData.tokenKey);
      var body = json.encode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.put(
        urlParse,
        body: body,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200) {
        setState(() {
          ticketStatus = "Mark As Complete";
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void getProfile() async{
    try {
      var profileData = await Repository().getProfileData();
      if(profileData != null) {
        profileDataList = jsonDecode(profileData);
      }
    } catch (e) {
      log(e.toString());
    }
  }

}
