import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:ticket_resolver_system/Repository/repository.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';

import '../widgets/constant.dart';

class ReportFormScreen extends StatefulWidget {
  String? partyName;
  String partyId;
  String ticketId;

  ReportFormScreen(
      {Key? key, this.partyName, required this.partyId, required this.ticketId})
      : super(key: key);

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  String? value;
  Uint8List? sign;
  bool isDisabled = false;
  bool showSignaturepad = false;
  final formkey = GlobalKey<FormState>();
  late SignatureController signController;
  late TextEditingController pN;
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
    signController =
        SignatureController(penColor: Colors.black, penStrokeWidth: 3);
    pN = TextEditingController();
    pN.text = widget.partyName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report form",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 10, bottom: 10),
          child: Stack(children: [
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommenTextfield(controller: pN, field: false),
                  const SizedBox(height: 10),
                  CommenTextfield(
                      hintText: "Mlc type & model",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Machine type";
                        } else {
                          return null;
                        }
                      },
                      controller: mlcController),
                  const SizedBox(height: 10),
                  CommenTextfield(
                    hintText: "Nature of Complaint",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Nature of complain";
                      } else {
                        return null;
                      }
                    },
                    controller: complaintController,
                  ),
                  const SizedBox(height: 10),
                  CommenTextfield(
                    hintText: "Action taken",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Action taken";
                      } else {
                        return null;
                      }
                    },
                    controller: actionController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BigText(text: "Parameter details"),
                  Row(
                    children: [
                      CommenSmallTextfield(
                        hintText: 'Power',
                        controller: power,
                      ),
                      SizedBox(width: screenWidth(context, dividedBy: 20)),
                      CommenSmallTextfield(hintText: "Amp", controller: amp),
                    ],
                  ),
                  Row(
                    children: [
                      CommenSmallTextfield(
                        hintText: 'Frequency',
                        controller: frqn,
                      ),
                      SizedBox(width: screenWidth(context, dividedBy: 20)),
                      CommenSmallTextfield(
                          hintText: "Voltage", controller: voltage),
                    ],
                  ),
                  Row(
                    children: [
                      CommenSmallTextfield(
                        hintText: 'Temp.',
                        controller: temp,
                      ),
                      SizedBox(width: screenWidth(context, dividedBy: 20)),
                      CommenSmallTextfield(hintText: "Item", controller: item),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommenSmallTextfield(
                      hintText: 'Sr no.',
                      controller: srno,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BigText(text: "Cost"),
                  Container(
                    width: screenWidth(context, dividedBy: 2.2),
                    alignment: Alignment.centerLeft,
                    // decoration: BoxDecoration(border: Border.all()),
                    child: CommenTextfield(
                      controller: amount,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Amount";
                        } else {
                          return null;
                        }
                      },
                      hintText: "Amount",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BigText(text: "Signature"),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        showSignaturepad = true;
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: screenHeight(context, dividedBy: 5.5),
                        width: screenWidth(context, dividedBy: 2),
                        decoration: BoxDecoration(border: Border.all()),
                        child: ClipRRect(
                          child: (sign == null)
                              ? const Text(
                                  "Click here to sign",
                                  style: TextStyle(fontSize: 18),
                                )
                              : Image.memory(sign!),
                        ),
                      ),
                    ),
                  ),
                  CommenButton(
                      text: "Completed",
                      isDisabled: isDisabled,
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          Repository().feedbackForm(
                              context,
                              widget.partyId,
                              widget.ticketId,
                              mlcController.text,
                              complaintController.text,
                              actionController.text,
                              (power.text.isEmpty ? 0 : power.text) as int?,
                              (amp.text.isEmpty ? 0 : amp.text) as int?,
                              (frqn.text.isEmpty ? 0 : frqn.text) as int?,
                              (voltage.text.isEmpty ? 0 : voltage.text) as int?,
                              (temp.text.isEmpty ? 0 : temp.text) as int?,
                              (item.text.isEmpty ? 0 : item.text) as int?,
                              srno.text,
                              amount.text,
                              );
                        } else {
                          setState(() {
                            isDisabled = true;
                          });
                        }
                      })
                ],
              ),
            ),
            showSignaturepad
                ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: screenHeight(context, dividedBy: 4),
                    child: Container(
                      height: screenHeight(context, dividedBy: 1.7),
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                          border: Border.all(), color: Colors.white),
                      child: Column(
                        children: [
                          Expanded(
                            child: Signature(
                                controller: signController,
                                backgroundColor: Colors.yellow.shade100),
                          ),
                          const Divider(
                            height: 0,
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    if (signController.isNotEmpty) {
                                      final signature = await exportSignature();
                                      setState(() {
                                        sign = signature;
                                        showSignaturepad = false;
                                      });
                                    } else {
                                      setState(() {
                                        showSignaturepad = false;
                                      });
                                      ;
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.check_sharp,
                                    size: 32,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (signController.isEmpty) {
                                        setState(() {
                                          showSignaturepad = false;
                                        });
                                      } else {
                                        setState(() {
                                          signController.clear();
                                        });
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.clear_sharp,
                                    size: 32,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ))
                : Container()
          ]),
        ),
      ),
    );
  }

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
        penStrokeWidth: 3,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        points: signController.points);

    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature;
  }
}
