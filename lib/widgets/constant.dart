import 'package:flutter/material.dart';

import '../helper/screen_size.dart';

class BigText extends StatelessWidget {

  final String text;

  const BigText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: screenWidth(context),
      height: screenHeight(context, dividedBy: 16),
      decoration: BoxDecoration(border: Border.all(),color: Colors.yellow.shade50,),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
    );
  }
}

class SmallText extends StatelessWidget {

  final String text;

  const SmallText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  }
}

class DiscriptiveText extends StatelessWidget {

  final String text;
  final int maxline;

  const DiscriptiveText({
    super.key,
    required this.text,
    this.maxline = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(text,
        style: const TextStyle(fontSize: 16,color: Colors.grey,),
        maxLines: maxline,
      ),
    );
  }
}

class CommenTextfield extends StatefulWidget {

  String hintText;
  TextEditingController controller;

   CommenTextfield({
    super.key,
    required this.hintText,
     required this.controller
  });

  @override
  State<CommenTextfield> createState() => _CommenTextfieldState();
}

class _CommenTextfieldState extends State<CommenTextfield> {

  bool usernameEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      usernameFieldCheck();
    });
  }

  usernameFieldCheck() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        usernameEmpty = true;
      });
    } else {
      setState(() {
        usernameEmpty = false;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10,),
      height: screenHeight(context, dividedBy: 17),width: screenWidth(context),
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          alignLabelWithHint: true,
          hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          suffixIcon: (usernameEmpty) ? null : IconButton(
              onPressed: () {
                setState(() {
                  widget.controller.clear();
                });
              },
              icon: const Icon(Icons.cancel_sharp)),
        ),
      ),
    );
  }
}

class CommenSmallTextfield extends StatefulWidget {

  String hintText;
  TextEditingController controller;

   CommenSmallTextfield({
    super.key,
     required this.hintText,
     required this.controller
  });

  @override
  State<CommenSmallTextfield> createState() => _CommenSmallTextfieldState();
}

class _CommenSmallTextfieldState extends State<CommenSmallTextfield> {

  bool usernameEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      usernameFieldCheck();
    });
  }

  usernameFieldCheck() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        usernameEmpty = true;
      });
    } else {
      setState(() {
        usernameEmpty = false;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(
        left: 10,
      ),
      height: screenHeight(context, dividedBy: 17),
      width: screenWidth(context, dividedBy: 2.5),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          alignLabelWithHint: true,
          hintStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500),
          suffixIcon: (usernameEmpty) ? null : IconButton(
              onPressed: () {

                  widget.controller.clear();
              },
              icon: const Icon(Icons.cancel_sharp)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
