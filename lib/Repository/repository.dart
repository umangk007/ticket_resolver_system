import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resolver_system/screens/homepage_screen.dart';
import 'package:ticket_resolver_system/screens/report_form_screen.dart';

import '../models/profile_model.dart';
import '../models/ticket_model.dart';
import '../screens/reset_password_screen.dart';
import '../widgets/stored_data.dart';

class Repository {
  static const baseURL =
      "http://ticket-resolver-flyontech-env.eba-jzpfeppv.us-east-2.elasticbeanstalk.com";
  static const endPoint = "&status=ALLOCATION_COMPLETE,ONSITE";

  Future userLogIn(
      String username, String password, BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = "$baseURL/auth/login/";
      var data = {
        "username": username,
        "password": password,
      };
      var body = json.encode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.post(urlParse,
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        var userJson = jsonEncode(
            output["user_data"]); // converting json object in to string
        await StoredData.setToken(output["access_token"]);
        await StoredData.setUserData(userJson);
        String? storedUserJson = prefs.getString(StoredData.userKey);
        var jsonUser = jsonDecode(storedUserJson!);
        bool isFirst = jsonUser[StoredData.isFirstTimeKey];
        if (isFirst == true && context.mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen(),
              ));
        } else if (isFirst == false) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }
      } else if(context.mounted){
        const SnackBar snackBar = SnackBar(
          content: Text('Username or Password is invalid.'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }
    } catch (e) {
      const SnackBar snackBar = SnackBar(
        content: Text('Username or Password is invalid.'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }

  Future resetPassword(String password, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = "$baseURL/auth/reset_password/";
      var data = {
        "password": password,
      };
      String? token = prefs.getString(StoredData.tokenKey);
      var body = json.encode(data);
      var urlParse = Uri.parse(url);
      Response response = await http.patch(
        urlParse,
        body: body,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 && context.mounted) {
        Map<String, dynamic> output = json.decode(response.body);
        var userJson =
            jsonEncode(output); // converting json object in to string
        StoredData.setUserData(userJson);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<TicketModel?> getData() async {
    TicketModel? response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(StoredData.tokenKey);
    String? storedUserJson = prefs.getString(StoredData.userKey);
    var jsonUser = jsonDecode(storedUserJson!);
    var id = jsonUser[StoredData.keyId];
    var url = "$baseURL/api/ticket/?engineer_id__id=$id$endPoint";
    var urlParse = Uri.parse(url);
    try {
      Response ticketResponse = await http.get(
        urlParse,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (ticketResponse.statusCode == 200) {
       return response = TicketModel.fromJson(json.decode(ticketResponse.body));
      }
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future completeTicket(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUserJson = prefs.getString(StoredData.userKey);
      var jsonUser = jsonDecode(storedUserJson!);
      var id = jsonUser[StoredData.keyId];
      var url = "$baseURL/api/complete_ticket/$id/";
      var data = {
        "status": "RESOLVED",
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
      if (response.statusCode == 200 && context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReportFormScreen(),
            ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getProfileData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(StoredData.tokenKey);
    String? storedUserJson = prefs.getString(StoredData.userKey);
    var jsonUser = jsonDecode(storedUserJson!);
    var id = jsonUser[StoredData.keyId];
    var url = "$baseURL/api/user/$id";
    var urlParse = Uri.parse(url);
    try {
      Response profileResponse = await http.get(
        urlParse,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (profileResponse.statusCode == 200) {
        String response;
       return response = profileResponse.body;
      }
    } catch (e) {
      log(e.toString());
    }
  }

}
