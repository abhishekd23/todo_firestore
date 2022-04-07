import 'package:flutter/material.dart';

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
