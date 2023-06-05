import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resolver_system/Repository/repository.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';
import 'package:ticket_resolver_system/models/ticket_model.dart';
import 'package:ticket_resolver_system/screens/report_form_screen.dart';
import 'package:upgrader/upgrader.dart';

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
  late Map<String, dynamic> profileDataList;
  late bool isLoading;
  late bool hasTicket;
  late bool profileLoading;
  late String ticketStatus;

  @override
  void initState() {
    super.initState();
    getTicketData();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Ticket"),
        centerTitle: true,
      ),
      body: UpgradeAlert(
        upgrader: Upgrader(
          durationUntilAlertAgain: const Duration(days: 1),
          canDismissDialog: true,
          showIgnore: false,
          shouldPopScope: () => true,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            onRefresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(children: [
              Container(
                height: screenHeight(context),
                margin: const EdgeInsets.only(left: 15, right: 5),
                child: isLoading
                    ? Container(
                        margin: EdgeInsets.only(
                            bottom: screenHeight(context, dividedBy: 5)),
                        alignment: Alignment.center,
                        child: hasTicket
                            ? LoadingPage()
                            : const Text("No active ticket available.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 20)),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigText(text: "Complain Info"),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Complain "),
                              Expanded(
                                child: DiscriptiveText(
                                    text: activeTicket[0].complain?.complain ??
                                        activeTicket[0].customComplain),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 80),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Time "),
                              Expanded(
                                child: DiscriptiveText(
                                  text: activeTicket[0].time != null
                                      ? DateFormat('MM/dd/yyyy h:mm a').format(
                                          activeTicket[0].time!.toLocal())
                                      : "",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 80),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Assigned by"),
                              Expanded(
                                child: DiscriptiveText(
                                  text:
                                      "${activeTicket[0].callRecivedBy?.firstName} ${activeTicket[0].callRecivedBy?.lastName}" ??
                                          "",
                                ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Name"),
                              Expanded(
                                child: DiscriptiveText(
                                  text: activeTicket[0].party?.name ?? "",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 80),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Phone"),
                              Expanded(
                                child: DiscriptiveText(
                                  text: activeTicket[0].party?.mobileNo ?? "",
                                ),
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
                              Expanded(
                                child: DiscriptiveText(
                                  text: activeTicket[0].party?.address ?? "",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          const BigText(text: "Party owner Info"),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Name"),
                              Expanded(
                                child: DiscriptiveText(
                                  text:
                                      "${activeTicket[0].party?.owner["first_name"]} ${activeTicket[0].party?.owner["last_name"]}" ??
                                          "",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 80),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: "Phone"),
                              Expanded(
                                child: DiscriptiveText(
                                  text: activeTicket[0]
                                          .party
                                          ?.owner["mobile_no"] ??
                                      "",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 20),
                          ),
                          CommenButton(
                              text: ticketStatus,
                              onTap: () {
                                if (ticketStatus == "Start") {
                                  startTicket();
                                } else if (ticketStatus == "Mark As Complete") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReportFormScreen(
                                                partyName:
                                                    activeTicket[0].party?.name,
                                                partyId: activeTicket[0]
                                                    .party!
                                                    .id
                                                    .toString(),
                                                ticketId: activeTicket[0]
                                                    .id
                                                    .toString(),
                                              )));
                                }
                              })
                        ],
                      ),
              ),
            ]),
          ),
        ),
      ),
      drawer: profileLoading
          ? MyDrawer()
          : MyDrawer(
              profilePic: profileDataList["profile_pic"].toString(),
              firstName: profileDataList["first_name"].toString(),
              lastName: profileDataList["last_name"].toString(),
              phone: profileDataList["mobile_no"].toString(),
              email: profileDataList["email"].toString(),
              address: profileDataList["address"].toString(),
              city: profileDataList["city"].toString(),
              state: profileDataList["state"].toString(),
              dateJoined: profileDataList["date_joined"].toString(),
            ),
    );
  }

  void getTicketData() async {
    try {
      setState(() {
        isLoading = true;
        hasTicket = true;
      });
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
        } else {
          ticketStatus = "";
        }
      }
    } catch (e) {
      isLoading = true;
      hasTicket = false;
      ticketStatus = "";
    }
  }

  Future startTicket() async {
    setState(() {
      isLoading = true;
      hasTicket = true;
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = activeTicket[0].id;
      var url = "${Repository.baseURL}/api/start_ticket/$id/";
      var data = {
        "status": "ONSITE",
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
      if (response.statusCode == 200) {
        setState(() {
          ticketStatus = "Mark As Complete";
          isLoading = false;
          hasTicket = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasTicket = false;
      });
      // log(e.toString());
    }
  }

  void getProfile() async {
    try {
      profileLoading = true;
      var profileData = await Repository().getProfileData();
      if (profileData != null) {
        profileDataList = await jsonDecode(profileData);
        setState(() {
          profileLoading = false;
        });
      }
    } catch (e) {
      profileLoading = true;
      //log(e.toString());
    }
  }

  void onRefresh() {
    activeTicket.clear();
    profileDataList.clear();
    getTicketData();
    getProfile();
    setState(() {});
  }
}
