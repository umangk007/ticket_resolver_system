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
      alignment: Alignment.centerLeft,
      width: screenWidth(context),
      height: screenHeight(context, dividedBy: 15),
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
