import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_firestore/model/status.dart';

class TaskRetrieval {
  FirebaseAuth? auth;
  Status? currentState = Status.SHOW_MOBILE_FORM_STATE;
  String? verficationId;
  TaskRetrieval() {
    auth = FirebaseAuth.instance;
  }

  Future<void> verifyPhoneNumber(String number) async {
    //print(number);
    await auth?.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) async {
        this.currentState = Status.SUCCESS_STATUS;
        print("Abhishek");
      },
      verificationFailed: (verificationFailed) async {
        this.currentState = Status.ERROR_STATUS;
        print(verificationFailed);
        print("Abhi");
      },
      codeSent: (verificationId, resendingToken) async {
        this.currentState = Status.SHOW_OTP_FORM_STATE;
        //print(currentState);
        this.verficationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
    this.currentState = Status.SHOW_OTP_FORM_STATE;
  }

  Future<void> signInWithPhoneAuthCredential(
      String verificationId, String otpText) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpText);
    try {
      final authCredential =
          await auth?.signInWithCredential(phoneAuthCredential);

      if (authCredential?.user != null) {
        // userSetup(phoneController.text);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TaskScreen(
        //           phoneController: phoneController,
        //         )));
      }
    } on FirebaseAuthException catch (e) {
      currentState = Status.ERROR_STATUS;
    }
  }

  Future<User?> getCurrentUser() async {
    return auth?.currentUser;
  }
}
