import 'package:rapatory/src/api/api_provider.dart';
import 'package:rapatory/src/model/login/login_body.dart';
import 'package:rapatory/src/model/login/login_response.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future<LoginResponse> sendLoginUser(LoginBody loginBody) => _apiProvider.loginUser(loginBody);
}