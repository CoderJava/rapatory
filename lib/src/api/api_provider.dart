import 'package:dio/dio.dart';
import 'package:rapatory/src/model/login/login_body.dart';
import 'package:rapatory/src/model/login/login_response.dart';

class ApiProvider {
  Dio _dio = Dio();
  final _baseUrlFakeJson = 'http://api.bengkelrobot.net:8002/api/rapatory';

  Future<LoginResponse> loginUser(LoginBody loginBody) async {
    final response = await _dio.post('$_baseUrlFakeJson/login', data: loginBody.toJson());
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('${response.statusMessage}');
    }
  }
}