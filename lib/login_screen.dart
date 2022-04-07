import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore/task_screen.dart';
import 'package:todo_app_firestore/utils/app_bar.dart';
import 'package:todo_app_firestore/utils/constants.dart';
import 'package:todo_app_firestore/utils/rounded_button.dart';
import 'package:todo_app_firestore/view_model/task_view_model.dart';
import 'package:todo_app_firestore/views/mobileForm.dart';
import 'package:todo_app_firestore/views/otp_form.dart';

import 'model/status.dart';

TextEditingController phoneController = TextEditingController();
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  late String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _passwordController = TextEditingController();

  final _otpController = TextEditingController();

  Future<void> userSetup(String displayName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .set({'userId': auth.currentUser!.uid});

    String uid = auth.currentUser!.uid.toString();
    return;
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showSpinner = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showSpinner = false;
      });
      if (authCredential.user != null) {
        userSetup(phoneController.text);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskScreen(
                      phoneController: phoneController,
                    )));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("${e.message}"),
        ),
      );
    }
  }

  getMobileFormWidget(context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: phoneController,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.black87,
                  ),
                  labelText: "Phone",
                  labelStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                  colour: Colors.teal,
                  text: "SEND",
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    await _auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showSpinner = false;
                        });
                        _scaffoldKey.currentState?.showSnackBar(
                          SnackBar(
                            content: Text("${verificationFailed.message}"),
                          ),
                        );
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showSpinner = false;
                          currentState =
                              MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  }),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _otpController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: kTextFieldDecoration.copyWith(
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.black87,
                  ),
                  labelText: "Enter OTP",
                  labelStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                  colour: Colors.teal,
                  text: "Verify",
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: _otpController.text);
                    signInWithPhoneAuthCredential(phoneAuthCredential);
                  }),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Status? current;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskModel mod = new TaskModel();
    current = mod.getCurrentState();
    print(current);
  }

  @override
  Widget build(BuildContext context) {
    TaskModel model = context.watch<TaskModel>();
    //print(model.currentState);
    //print(model.setCurrentState());
    // Status? current = model.getCurrentState();
    // print(current);
    return ChangeNotifierProvider(
      create: (context) => TaskModel(),
      child: SafeArea(
        child: Scaffold(
            //key: _scaffoldKey,
            appBar: AppBars(
              title: Text("Login Page"),
              backgroundColor: Colors.teal,
              appBar: AppBar(),
            ),
            backgroundColor: Colors.teal,
            body: Container(
              child: model.showSpinner
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : model.currentState == Status.SHOW_MOBILE_FORM_STATE
                      ? MobileFormWidget()
                      : OtpForm(),
              padding: EdgeInsets.all(16),
            )),
      ),
    );
  }
}
