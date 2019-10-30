import 'package:flutter/material.dart';
import 'package:rapatory/res/values/color_app.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndexBottomNavigationBar;

  @override
  void initState() {
    _currentIndexBottomNavigationBar = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildWidgetBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexBottomNavigationBar,
        onTap: (int indexItemSelected) {
          setState(() => _currentIndexBottomNavigationBar = indexItemSelected);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Groups'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Chats'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorApp.colorPrimary,
        selectedItemColor: Colors.grey[200],
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildWidgetBody() {
    if (_currentIndexBottomNavigationBar == 0) {
      return Container(
        child: Center(
          child: Text('Dashboard Events'),
        ),
      );
    } else if (_currentIndexBottomNavigationBar == 1) {
      return Container(
        child: Center(
          child: Text('Dashboard Groups'),
        ),
      );
    } else if (_currentIndexBottomNavigationBar == 2) {
      return Container(
        child: Center(
          child: Text('Dashboard Notifications'),
        ),
      );
    } else if (_currentIndexBottomNavigationBar == 3) {
      return Container(
        child: Center(
          child: Text('Dashboard Chats'),
        ),
      );
    } else {
      return Container();
    }
  }
}
