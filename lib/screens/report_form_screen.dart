import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:ticket_resolver_system/Repository/repository.dart';
import 'package:ticket_resolver_system/helper/screen_size.dart';
import 'package:permission_handler/permission_handler.dart';

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
  bool isLoading = false;
  bool showSignaturepad = false;
  String directoryName = 'Signature';
  String? uploadedImageUrl = '';
  final formkey = GlobalKey<FormState>();
  late SignatureController signController;
  late TextEditingController pN;
  TextEditingController amp = TextEditingController();
  TextEditingController frqn = TextEditingController();
  TextEditingController temp = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController srno = TextEditingController();
  TextEditingController power = TextEditingController();
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
        title: const Text("Report form"),
        centerTitle: true,
      ),
      body: Stack(children: [
        SingleChildScrollView(
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
                    const SizedBox(
                      height: 10,
                    ),
                    CommenTextfield(
                      hintText: "Mlc type & model *",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      controller: mlcController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CommenTextfield(
                      hintText: "Nature of Complaint *",
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      controller: complaintController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CommenTextfield(
                      hintText: "Action taken *",
                      textInputType: TextInputType.multiline,
                      minLine: 3,
                      maxLine: 5,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
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
                        CommenSmallTextfield(
                            hintText: "Item", controller: item),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommenSmallTextfield(
                        hintText: 'Sr no.',
                        controller: srno,
                        isDouble: false,
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
                        text: "Complete",
                        isDisabled: isDisabled,
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            if (signController.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              await saveImageToMobile();
                              // ignore: use_build_context_synchronously
                              await Repository().feedbackForm(
                                  context,
                                  widget.partyId,
                                  widget.ticketId,
                                  mlcController.text,
                                  complaintController.text,
                                  actionController.text,
                                  (power.text.isEmpty
                                      ? 0
                                      : double.parse(power.text)),
                                  (amp.text.isEmpty
                                      ? 0
                                      : double.parse(amp.text)),
                                  (frqn.text.isEmpty
                                      ? 0
                                      : double.parse(frqn.text)),
                                  (voltage.text.isEmpty
                                      ? 0
                                      : double.parse(voltage.text)),
                                  (temp.text.isEmpty
                                      ? 0
                                      : double.parse(temp.text)),
                                  (item.text.isEmpty
                                      ? 0
                                      : double.parse(item.text)),
                                  srno.text.isEmpty ? "null" : srno.text,
                                  uploadedImageUrl);
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              const SnackBar snackBar = SnackBar(
                                content: Text('Please add Signature.'),
                                backgroundColor: Colors.deepOrange,
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                isDisabled = true;
                              });
                            }
                          } else {
                            setState(() {
                              isDisabled = true;
                              isLoading = false;
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
                                        final signature =
                                            await exportSignature();
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
        isLoading ? LoadingPage() : const SizedBox()
      ]),
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

  String formattedDate() {
    DateTime dateTime = DateTime.now();
    String dateTimeString =
        'Signature_${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}:${dateTime.minute}:${dateTime.second}:${dateTime.millisecond}:${dateTime.microsecond}';
    return dateTimeString;
  }

  saveImageToMobile() async {
    Directory? directory = await getApplicationDocumentsDirectory();
    String? path = directory.path;
    var filePath = '$path/$directoryName/${formattedDate()}.png';
    await Directory('$path/$directoryName').create(recursive: true);
    File(filePath).writeAsBytesSync(sign!.buffer.asInt8List());
    File file = File(filePath);
    var imageUrl = await Repository().feedbackPost(file);
    setState(() {
      uploadedImageUrl = imageUrl;
    });
  }
}
