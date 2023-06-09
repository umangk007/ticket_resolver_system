import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/screen_size.dart';

const Color green = Color.fromARGB(255, 43, 173, 101);

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
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 42, 174, 101))),
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
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const Text(":",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ));
  }
}

class DiscriptiveText extends StatelessWidget {
  final String text;

  const DiscriptiveText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );
  }
}

class CommenTextfield extends StatefulWidget {
  String? hintText;
  bool? field;
  TextInputType? textInputType;
  int? minLine;
  int? maxLine;
  String? Function(String?)? validate;
  TextEditingController controller;

  CommenTextfield({
    super.key,
    this.hintText,
    this.field,
    this.textInputType,
    this.minLine,
    this.maxLine,
    this.validate,
    required this.controller,
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
    return TextFormField(
      controller: widget.controller,
      enabled: widget.field,
      keyboardType: widget.textInputType,
      minLines: widget.minLine,
      maxLines: widget.maxLine,
      style: const TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        focusColor: green,
        contentPadding: const EdgeInsets.only(top: 15, left: 15),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: green),
            borderRadius: BorderRadius.circular(8)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: green),
            borderRadius: BorderRadius.circular(8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        errorStyle: const TextStyle(fontSize: 0.01),
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
      validator: widget.validate,
    );
  }
}

class CommenSmallTextfield extends StatefulWidget {
  String hintText;
  bool? isDouble;
  String? Function(String?)? validate;
  TextEditingController controller;

  CommenSmallTextfield(
      {super.key,
      required this.hintText,
      this.isDouble = true,
      required this.controller,
      this.validate});

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
        keyboardType: widget.isDouble!
            ? const TextInputType.numberWithOptions(signed: true, decimal: true)
            : null,
        style: const TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
          focusColor: green,
          contentPadding: const EdgeInsets.only(top: 15, left: 15),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green),
              borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: green),
              borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          errorStyle: const TextStyle(fontSize: 0.01),
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
        validator: widget.validate,
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
            height: 50,
            width: screenWidth(context, dividedBy: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 42, 174, 101)),
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          if (isDisabled) ...[
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

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
        ),
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}
