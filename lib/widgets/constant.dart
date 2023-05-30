import 'package:flutter/material.dart';

import '../helper/screen_size.dart';

const Color green = Color.fromARGB(255, 43, 173, 101);

////////////////////////////////////////////////////////////////////////////////
class BigText extends StatelessWidget {
  final String text;

  const BigText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, color: green)),
        Expanded(
          child: Container(
            height: 20,
            padding: const EdgeInsets.only(top: 2),
            alignment: Alignment.centerLeft,
            child: const Divider(
              thickness: 1,
              height: 0,
              color: green,
              endIndent: 5,
              indent: 5,
            ),
          ),
        )
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class SmallText extends StatelessWidget {
  final String text;

  const SmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: screenWidth(context, dividedBy: 3.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const Text(":",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ));
  }
}

////////////////////////////////////////////////////////////////////////////////
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
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87.withOpacity(0.7),
          ),
          maxLines: maxline,
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
class CommenTextfield extends StatefulWidget {
  String? hintText;
  bool? field;
  TextEditingController controller;

  CommenTextfield(
      {super.key, this.hintText, required this.controller, this.field});

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
      alignment: Alignment.center,
      height: screenHeight(context, dividedBy: 17),
      child: TextFormField(
        enabled: widget.field,
        controller: widget.controller,
        decoration: InputDecoration(
          focusColor: green,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.only(top: 3, left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          suffixIcon: (usernameEmpty)
              ? null
              : IconButton(
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

////////////////////////////////////////////////////////////////////////////////
class CommenSmallTextfield extends StatefulWidget {
  String hintText;
  TextEditingController controller;

  CommenSmallTextfield(
      {super.key, required this.hintText, required this.controller});

  @override
  State<CommenSmallTextfield> createState() => _CommenSmallTextfieldState();
}

class _CommenSmallTextfieldState extends State<CommenSmallTextfield> {
  bool usernameEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.centerLeft,
      height: screenHeight(context, dividedBy: 18),
      width: screenWidth(context, dividedBy: 2.3),
      child: TextFormField(
        controller: widget.controller,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 3, left: 10),
          focusColor: green,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          suffixIcon: (usernameEmpty)
              ? null
              : IconButton(
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
}

////////////////////////////////////////////////////////////////////////////////
class CommenButton extends StatelessWidget {
  final String text;
  bool isDisabled;
  final VoidCallback onTap;

  CommenButton(
      {super.key,
      required this.text,
      this.isDisabled = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(children: [
          Container(
            height: screenHeight(context, dividedBy: 17),
            width: screenWidth(context, dividedBy: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: green),
            child: Text(text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ),
          if (isDisabled)...[
            Container(
              height: screenHeight(context, dividedBy: 17),
              width: screenWidth(context, dividedBy: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.withOpacity(0.4)),
            ),
          ]
        ]),
      ),
    );
  }
}
