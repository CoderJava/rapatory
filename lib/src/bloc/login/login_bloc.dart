import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rapatory/src/api/api_repository.dart';
import 'package:rapatory/src/api/key/secret_loader.dart';
import 'package:rapatory/src/model/login/login_body.dart';
import 'package:rapatory/src/model/login/login_response.dart';
import 'package:rapatory/src/storage/sharedpreferences/shared_preferences_manager.dart';

abstract class LoginState {}

enum TypeLogin { twitter, facebook, google }

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);
}

class LoginEvent {
  final TypeLogin typeLogin;
  final String username;
  final String password;

  LoginEvent({this.typeLogin, this.username, this.password});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState {
    return LoginInitial();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    final ApiRepository apiRepository = ApiRepository();
    if (event.typeLogin == TypeLogin.twitter) {
      yield LoginLoading();
      var secret = await SecretLoader(secretPath: 'secrets.json').load();
      var twitterLogin = TwitterLogin(
        consumerKey: secret.twitterConsumerKey,
        consumerSecret: secret.twitterConsumerSecret,
      );
      final result = await twitterLogin.authorize();
      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          var session = result.session;
          var token = session.token;
          var secret = session.secret;
          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          AuthCredential credential =
              TwitterAuthProvider.getCredential(authToken: token, authTokenSecret: secret);
          FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
          if (firebaseUser != null) {
            LoginBody loginBody =
                LoginBody(typeLogin: 'twitter', username: session.username, password: token);
            LoginResponse loginResponse = await apiRepository.sendLoginUser(loginBody);
            if (loginResponse != null) {
              await updateSharedPreferencesLogin(true);
              yield LoginSuccess();
            } else {
              await updateSharedPreferencesLogin(false);
              yield LoginFailed(loginResponse.message);
            }
          } else {
            await updateSharedPreferencesLogin(false);
            yield LoginFailed('User not found');
          }
          break;
        case TwitterLoginStatus.cancelledByUser:
          await updateSharedPreferencesLogin(false);
          yield LoginFailed('Login cancelled by user');
          break;
        case TwitterLoginStatus.error:
          await updateSharedPreferencesLogin(false);
          yield LoginFailed('${result.errorMessage}');
          break;
      }
    } else if (event.typeLogin == TypeLogin.facebook) {
      final FacebookLogin facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          String token = result.accessToken.token;
          AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token);
          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
          if (firebaseUser != null) {
            LoginBody loginBody =
                LoginBody(typeLogin: 'facebook', username: firebaseUser.email, password: token);
            LoginResponse loginResponse = await apiRepository.sendLoginUser(loginBody);
            if (loginResponse != null) {
              await updateSharedPreferencesLogin(true);
              yield LoginSuccess();
            } else {
              await updateSharedPreferencesLogin(false);
              yield LoginFailed(loginResponse.message);
            }
          } else {
            await updateSharedPreferencesLogin(false);
            yield LoginFailed('user not found');
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          await updateSharedPreferencesLogin(false);
          yield LoginFailed('Login cancelled by user');
          break;
        case FacebookLoginStatus.error:
          await updateSharedPreferencesLogin(false);
          yield LoginFailed('${result.errorMessage}');
          break;
      }
    } else if (event.typeLogin == TypeLogin.google) {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
      if (firebaseUser != null) {
        LoginBody loginBody = LoginBody(typeLogin: 'google', username: firebaseUser.email, password: googleAuth.accessToken);
        LoginResponse loginResponse = await apiRepository.sendLoginUser(loginBody);
        if (loginResponse != null) {
          await updateSharedPreferencesLogin(true);
          yield LoginSuccess();
        } else {
          await updateSharedPreferencesLogin(false);
          yield LoginFailed(loginResponse.message);
        }
      } else {
        await updateSharedPreferencesLogin(false);
        yield LoginFailed('user not found');
      }
    } else {
      yield LoginFailed('Unknown type login');
    }
  }

  Future<bool> updateSharedPreferencesLogin(bool loginSuccess) async {
    final SharedPreferencesManager sharedPreferencesManager =
        await SharedPreferencesManager.getInstance();
    return await sharedPreferencesManager.putBool(SharedPreferencesManager.keyIsLogin, true);
  }
}
