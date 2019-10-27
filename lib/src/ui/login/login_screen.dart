import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapatory/src/bloc/login/login_bloc.dart';
import 'package:rapatory/src/bloc/splash/splash_bloc.dart';
import 'package:rapatory/src/widgets/widget_background_video.dart';
import 'package:rapatory/src/widgets/widget_loading_screen.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  SplashBloc _splashBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    _splashBloc = SplashBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _splashBloc.dispatch(SplashEvent());
    });
    super.initState();
  }

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          builder: (context) => _loginBloc,
        ),
        BlocProvider<SplashBloc>(
          builder: (context) => _splashBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              _checkListenerStatusLogin(state);
            },
          ),
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashSuccess) {
                bool isLogin = state.isLogin;
                if (isLogin) {
                  _navigatorToHomeScreen();
                }
              }
            },
          ),
        ],
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
      _navigatorToHomeScreen();
    }
  }

  void _navigatorToHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(_scaffoldState.currentContext, '/home', (route) => false);
  }

  Widget _buildWidgetButtonLoginTwitter(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        _loginBloc.dispatch(LoginEvent(typeLogin: TypeLogin.twitter));
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
        _loginBloc.dispatch(LoginEvent(typeLogin: TypeLogin.facebook));
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
