import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore/login_screen.dart';
import 'package:todo_app_firestore/task_screen.dart';
import 'package:todo_app_firestore/view_model/task_view_model.dart';

import 'utils/change_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeModel>(context).currentTheme,
        home: InitialerWidget(),
      ),
    );
  }
}

class InitialerWidget extends StatefulWidget {
  const InitialerWidget({Key? key}) : super(key: key);

  @override
  State<InitialerWidget> createState() => _InitialerWidgetState();
}

class _InitialerWidgetState extends State<InitialerWidget> {
  FirebaseAuth? _auth;
  User? _user;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    TaskModel model = context.watch<TaskModel>();
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? LoginScreen()
            : TaskScreen();
  }
}
