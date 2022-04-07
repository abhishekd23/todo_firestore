import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app_firestore/model/task_retrieving.dart';

import '../model/status.dart';

class TaskModel extends ChangeNotifier {
  TaskRetrieval? taskRetrieval = new TaskRetrieval();
  FirebaseAuth? auth;
  PhoneAuthCredential? phoneAuthCredential;
  Status? current;
  bool showSpinner = false;
  User? user;
  String? verificationId;
  Status? currentState = Status.SHOW_MOBILE_FORM_STATE;

  setSpinner(bool val) {
    showSpinner = val;
    notifyListeners();
  }

  Future<void> verifyUser(String num) async {
    await taskRetrieval?.verifyPhoneNumber(num);
    setCurrentState();
    setSpinner(false);
    //this.currentState = Status.SHOW_OTP_FORM_STATE;
    notifyListeners();
  }

  void getUser() {
    auth = taskRetrieval?.auth;
    user = auth?.currentUser;
    notifyListeners();
  }

  Future<void> signUpUser(String verificationId, String num) async {
    await taskRetrieval?.signInWithPhoneAuthCredential(verificationId, num);
    notifyListeners();
  }

  // getStatus() {
  //   current = taskRetrieval?.currentState;
  // }

  bool getUsers() {
    if (taskRetrieval?.getCurrentUser() != null) {
      return true;
    }
    return false;
  }

  getVerficationId() {
    verificationId = taskRetrieval?.verficationId;
    notifyListeners();
  }

  setCurrentState() {
    this.currentState = taskRetrieval?.currentState;
    //print(this.currentState);
    notifyListeners();
  }

  getCurrentState() {
    setCurrentState();
    return currentState;
  }
}
