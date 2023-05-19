import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({Key? key}) : super(key: key);

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {

  final parties = ["Party 1","Party 2","Party 3","Party 4","Party 5",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report form"),
      ),
      body: Container(
        child: Column(
          children: [
            DropdownButton<String>(items: parties.map(buildMenuItem).toList(), onChanged: onChanged)
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(child: child);

}
