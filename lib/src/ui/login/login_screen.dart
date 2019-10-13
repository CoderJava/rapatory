import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
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
            _buildWidgetButtonLoginTwitter(),
            SizedBox(height: 8.0),
            _buildWidgetButtonLoginFacebook(),
            SizedBox(height: 8.0),
            _buildWidgetButtonLoginGoogle(),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonLoginTwitter() {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        var twitterLogin = TwitterLogin(
          consumerKey: '0LFgIbMd0onKleprkoGvVWv0J',
          consumerSecret: 'KzqzH7JnsQjzfDGT49fPsvRI6mqarj5YJhAxQBEixy0zgD4H6l',
        );
        final TwitterLoginResult result = await twitterLogin.authorize();
        switch (result.status) {
          case TwitterLoginStatus.loggedIn:
            var session = result.session;
            var token = session.token;
            var secret = session.secret;
            print('token: ${session.token} & secret: ${session.secret}');
            print('userId: ${session.userId} & username: ${session.username}');

            FirebaseAuth auth = FirebaseAuth.instance;
            AuthCredential credential = TwitterAuthProvider.getCredential(authToken: token, authTokenSecret: secret);
            FirebaseUser user = (await auth.signInWithCredential(credential)).user;
            if (user != null) {
              print('Successfully signed with Twitter. ${user.uid}');
              print('email: ${user.email}');
              print('photo profile: ${user.photoUrl}');
              print('display name: ${user.displayName}');
              // TODO: do something in here
            } else {
              print('Failed to sign in Twitter.') ;
              // TODO: do something in here
            }
            break;
          case TwitterLoginStatus.cancelledByUser:
            print('cancelled by user');
            // TODO: do something in here
            break;
          case TwitterLoginStatus.error:
            print('error twitter: ${result.errorMessage}');
            // TODO: do something in here
            break;
        }
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
