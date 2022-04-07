import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/rounded_button.dart';
import '../view_model/task_view_model.dart';

class OtpForm extends StatefulWidget {
  OtpForm({this.otp});
  final TextEditingController? otp;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  Widget build(BuildContext context) {
    TaskModel model = context.watch<TaskModel>();
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
                controller: widget.otp,
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
                    // PhoneAuthCredential phoneAuthCredential =
                    //     PhoneAuthProvider.credential(
                    //         verificationId: verificationId,
                    //         smsCode: _otpController.text);
                    // signInWithPhoneAuthCredential(phoneAuthCredential);
                    model.signUpUser(
                        model.verificationId.toString(), widget.otp.toString());
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
}
