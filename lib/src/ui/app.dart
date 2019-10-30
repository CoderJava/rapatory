import 'package:flutter/material.dart';
import 'package:rapatory/res/values/color_app.dart';
import 'package:rapatory/src/ui/dashboard/dashboard_screen.dart';
import 'package:rapatory/src/ui/login/login_screen.dart';
import 'package:rapatory/src/utils/route_keys.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorApp.colorPrimary,
        accentColor: ColorApp.colorAccent,
      ),
      routes: {
        RouteKeys.routeDashboard: (context) => DashboardScreen(),
        /*RouteKeys.routeDashboardEvents: (context) => DashboardEventsScreen(),*/
      },
      home: LoginScreen(),
    );
  }
}
