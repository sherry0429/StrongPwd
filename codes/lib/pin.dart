import 'dart:async';
import 'data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'main.dart';

// ignore: use_key_in_widget_constructors
class PinApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PinCodeVerificationScreen(
          phoneNumber:
          "+8801376221100"), // a random number, please don't call xD
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const PinCodeVerificationScreen({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  final Controller controller = Get.put(Controller());
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: null,
                ),
              ),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Pin Code Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: const TextSpan(
                      text: "Enter your personal ",
                      children: [
                        TextSpan(
                            text: "PIN Code",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style:
                      const TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "YOU CAN'T RESET IT !!!",
                    style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget: const FlutterLogo(
                        size: 24,
                      ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {},
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.black,
                        inactiveFillColor: Colors.white,
                        selectedColor: Colors.black,
                        selectedFillColor: Colors.white
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        formKey.currentState!.validate();

                        // conditions for validating
                        var verify = false;
                        if (controller.pin != "") {
                          if (controller.pinEqual(currentText)){
                            verify = true;
                          };
                        } else {
                          verify = true;
                          controller.pin = currentText;
                          controller.pinSave();
                        }
                        if (verify == true){
                          setState(
                                () {
                              hasError = false;
                              Get.to(() => HomeActivity());
                            },
                          );
                        } else {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                          textEditingController.clear();
                        }
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "* Please fill up all the cells properly" : "",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}