import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore/view_model/task_view_model.dart';

import '../utils/constants.dart';
import '../utils/rounded_button.dart';

class MobileFormWidget extends StatefulWidget {
  const MobileFormWidget({this.phoneController});

  final TextEditingController? phoneController;

  @override
  State<MobileFormWidget> createState() => _MobileFormWidgetState();
}

class _MobileFormWidgetState extends State<MobileFormWidget> {
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TaskModel model = context.watch<TaskModel>();
    return ChangeNotifierProvider(
      create: (context) => TaskModel(),
      child: Center(
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
                  controller: phone,
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
                      // setState(() {
                      //   showSpinner = true;
                      // });
                      setState(() {
                        model.setSpinner(true);
                      });

                      await model.verifyUser(phone.text);
                      //print(model.currentState);
                      setState(() {
                        model.setSpinner(false);
                      });
                      // await _auth.verifyPhoneNumber(
                      //   phoneNumber: phoneController.text,
                      //   verificationCompleted: (phoneAuthCredential) async {
                      //     setState(() {
                      //       showSpinner = false;
                      //     });
                      //   },
                      //   verificationFailed: (verificationFailed) async {
                      //     setState(() {
                      //       showSpinner = false;
                      //     });
                      //     _scaffoldKey.currentState?.showSnackBar(
                      //       SnackBar(
                      //         content: Text("${verificationFailed.message}"),
                      //       ),
                      //     );
                      //   },
                      //   codeSent: (verificationId, resendingToken) async {
                      //     setState(() {
                      //       showSpinner = false;
                      //       currentState =
                      //           MobileVerificationState.SHOW_OTP_FORM_STATE;
                      //       this.verificationId = verificationId;
                      //     });
                      //   },
                      //   codeAutoRetrievalTimeout: (verificationId) async {},
                      // );
                    }),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
