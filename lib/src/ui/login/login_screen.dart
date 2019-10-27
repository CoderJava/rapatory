import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapatory/src/bloc/login/login_bloc.dart';
import 'package:rapatory/src/widgets/widget_background_video.dart';
import 'package:rapatory/src/widgets/widget_loading_screen.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Stack(
        children: <Widget>[
          WidgetBackgroundVideo(),
          _buildWidgetButtonLogin(),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonLogin() {
    return BlocProvider(
      builder: (context) {
        return LoginBloc();
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          _checkListenerStatusLogin(state);
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildWidgetButtonLoginTwitter(context),
                        SizedBox(height: 8.0),
                        _buildWidgetButtonLoginFacebook(context),
                        SizedBox(height: 8.0),
                        _buildWidgetButtonLoginGoogle(),
                      ],
                    ),
                  ),
                  _checkWidgetStatusLogin(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _checkWidgetStatusLogin(LoginState loginState) {
    if (loginState is LoginLoading) {
      return WidgetLoadingScreen();
    } else {
      return Container();
    }
  }

  _checkListenerStatusLogin(LoginState state) {
    if (state is LoginFailed) {
      _scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text('${state.errorMessage}'),
        ),
      );
    } else if (state is LoginSuccess) {
      Navigator.pushNamed(_scaffoldState.currentContext, '/home');
    }
  }

  Widget _buildWidgetButtonLoginTwitter(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
        loginBloc.dispatch(LoginEvent(typeLogin: TypeLogin.twitter));
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

  Widget _buildWidgetButtonLoginFacebook(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
        loginBloc.dispatch(LoginEvent(typeLogin: TypeLogin.facebook));
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
