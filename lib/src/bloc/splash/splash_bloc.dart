import 'package:bloc/bloc.dart';
import 'package:rapatory/src/storage/sharedpreferences/shared_preferences_manager.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState {
  final bool isLogin;

  SplashSuccess(this.isLogin);
}

class SplashEvent {}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  @override
  SplashState get initialState => SplashInitial();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    SharedPreferencesManager sharedPreferencesManager = await SharedPreferencesManager.getInstance();
    bool isLogin = sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyIsLogin) && sharedPreferencesManager.getBool(SharedPreferencesManager.keyIsLogin);
    yield SplashSuccess(isLogin);
  }
}

