import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';

import '../widgets/constant.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({Key? key}) : super(key: key);

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final parties = [
    "Party 1",
    "Party 2",
    "Party 3",
    "Party 4",
    "Party 5",
  ];
  String? value;
  Uint8List? sign;
  bool showSignaturepad = false;
  final formkey = GlobalKey<FormState>();
  late SignatureController signController;
  TextEditingController amp = TextEditingController();
  TextEditingController frqn = TextEditingController();
  TextEditingController temp = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController srno = TextEditingController();
  TextEditingController power = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController voltage = TextEditingController();
  TextEditingController mlcController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController complaintController = TextEditingController();

  @override
  void initState() {
    super.initState();
    signController = SignatureController(
      penColor: Colors.black,
      penStrokeWidth: 3
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report form", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Stack(
            children: [
              Form(
                key: formkey,
                child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: screenHeight(context, dividedBy: 17),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: value,
                      iconSize: 36,
                      isExpanded: true,
                      isDense: true,
                      menuMaxHeight: screenHeight(context, dividedBy: 3.2),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      icon: const Icon(Icons.arrow_drop_down_sharp,
                          color: Colors.black),
                      hint: const Text("Party Name",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      items: parties.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() {
                        this.value = value;
                      }),
                    ),
                  ),
                  CommenTextfield(hintText: "Mlc type & model", controller: mlcController),
                  CommenTextfield(hintText: "Nature of Complaint", controller: complaintController,),
                  CommenTextfield(hintText: "Action taken", controller: actionController,),
                  const SizedBox(
                    height: 10,
                  ),
                  const BigText(text: "Parameter detailes :"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommenSmallTextfield(
                        hintText: 'Power',
                        controller: power,
                      ),
                      CommenSmallTextfield(hintText: "Amp", controller: amp),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommenSmallTextfield(
                        hintText: 'Frequency',
                        controller: frqn,
                      ),
                      CommenSmallTextfield(hintText: "Voltage", controller: voltage),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommenSmallTextfield(
                        hintText: 'Temp.',
                        controller: temp,
                      ),
                      CommenSmallTextfield(hintText: "Item", controller: item),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CommenSmallTextfield(
                      hintText: 'Sr no.',
                      controller: srno,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BigText(text: "Cost :"),
                  Align(
                    alignment: Alignment.center,
                    child: CommenSmallTextfield(
                      hintText: 'Amount',
                      controller: amount,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BigText(text: "Signature :"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: screenHeight(context, dividedBy: 6),width: screenWidth(context, dividedBy: 2.5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: ClipRRect(
                          child: (sign == null) ? null : Image.memory(sign!),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showSignaturepad = true;
                            });
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(Colors.amberAccent)
                          ),
                          child: const Text("Take Signature"))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(Colors.greenAccent)
                          ),
                          child: const Text("Completed"))
                    ],
                  )
                ],
            ),
              ),
             showSignaturepad ? Positioned(
                left: 0,
                  right: 0,
                  bottom: screenHeight(context, dividedBy: 4),
                  child: Container(
                    height: screenHeight(context, dividedBy: 1.7),
                    width: screenWidth(context),
                    decoration: BoxDecoration(border: Border.all(), color: Colors.white),
                    child: Column(
                      children: [
                        Expanded(
                          child: Signature(
                              controller: signController,
                              backgroundColor: Colors.yellow.shade100
                          ),
                        ),
                        const Divider(height: 0,color: Colors.black,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () async{
                                if(signController.isNotEmpty) {
                                  final signature = await exportSignature();
                                  setState(() {
                                    sign = signature;
                                    showSignaturepad = false;
                                  });
                                } else {
                                  setState(() {
                                    showSignaturepad = false;
                                  });;
                                }
                            }, icon: const Icon(Icons.check_sharp, size: 32,)),
                            IconButton(
                                onPressed: () {
                              setState(() {
                                if (signController.isEmpty) {
                                  setState(() {
                                    showSignaturepad = false;
                                  });
                                } else{
                                  setState(() {
                                    signController.clear();
                                  });
                                }
                              });
                            }, icon: const Icon(Icons.clear_sharp, size: 32,)),
                          ],
                        )
                      ],
                    ),
                  )) : Container()
            ]
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: signController.points
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature;
  }


}
