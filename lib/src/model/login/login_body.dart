import 'package:json_annotation/json_annotation.dart';
part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  @JsonKey(name: 'type_login') String typeLogin;
  String username;
  String password;

  LoginBody({this.typeLogin, this.username, this.password});

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  String toString() {
    return 'LoginBody{typeLogin: $typeLogin, username: $username, password: $password}';
  }


}