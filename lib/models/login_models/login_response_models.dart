import 'package:rider/models/login_models/login_models.dart';

class LoginResponseModel {
  final String? token;
  final LoginModels? user;

  LoginResponseModel({this.token, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      user: json['user'] != null ? LoginModels.fromJson(json['user']) : null,
    );
  }
}
