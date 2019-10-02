import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapatory/src/widgets/widget_background_video.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WidgetBackgroundVideo(),
          _buildWidgetButtonLogin(),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonLogin() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildwidgetButtonLoginTwitter(),
            SizedBox(height: 8.0),
            _buildWidgetButtonLoginFacebook(),
            SizedBox(height: 8.0),
            _buildWidgetButtonLoginGoogle(),
          ],
        ),
      ),
    );
  }

  Widget _buildwidgetButtonLoginTwitter() {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // TODO: do something in here
      },
      child: Row(
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            color: Colors.white.withOpacity(0.2),
            child: Icon(
              FontAwesomeIcons.twitter,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          Expanded(
            child: Text(
              'Sign in with Twitter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      color: Color(0xFF00ACEE),
    );
  }

  Widget _buildWidgetButtonLoginFacebook() {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // TODO: do something in here
      },
      child: Row(
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            color: Colors.white.withOpacity(0.2),
            child: Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          Expanded(
            child: Text(
              'Sign in with Facebook',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      color: Color(0xFF3B5998),
    );
  }

  Widget _buildWidgetButtonLoginGoogle() {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // TODO: do something in here
      },
      child: Row(
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            color: Colors.white.withOpacity(0.2),
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          Expanded(
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      color: Color(0xFF424242),
    );
  }
}
