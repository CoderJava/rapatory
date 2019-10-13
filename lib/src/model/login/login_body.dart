import 'package:json_annotation/json_annotation.dart';
part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  @JsonKey(name: 'type_login') String typeLogin;
  @JsonKey(name: 'username') String username;

  LoginBody({this.typeLogin, this.username});

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  String toString() {
    return 'LoginBody{typeLogin: $typeLogin, username: $username}';
  }


}