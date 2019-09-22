import 'package:flutter/material.dart';
import 'package:rapatory/res/values/color_app.dart';
import 'package:rapatory/src/ui/login/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ColorApp.colorPrimary,
        accentColor: ColorApp.colorAccent,
      ),
      home: LoginScreen(),
    );
  }
}
