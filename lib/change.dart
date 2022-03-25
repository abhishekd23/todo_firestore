import 'package:flutter/material.dart';

var darkTheme = ThemeData.dark();
var lightTheme = ThemeData.light();
enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;
  ThemeType _themeType = ThemeType.Dark;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour, this.text, this.onPressed});

  final colour;
  final Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Material(
          elevation: 5.0,
          color: colour,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            //hoverElevation: ,
            onPressed: onPressed,
            minWidth: 160.0,
            height: 42.0,
            child: Text(
              text!,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  const AppBars({this.title, this.backgroundColor, required this.appBar});

  final Color? backgroundColor;
  final Text? title;
  final AppBar appBar;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.black,
  hintStyle: TextStyle(
    fontSize: 15,
    //fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffffab41), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xffffab41), width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);

Color backgroundColor = const Color(0xffffab41);
