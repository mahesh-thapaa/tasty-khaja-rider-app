import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rider/models/login_models/login_request_models.dart';
import 'package:rider/models/login_models/login_response_models.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final _secureStorage = const FlutterSecureStorage();

  Future<LoginResponseModel?> loginRider(LoginRequestModel request) async {
    try {
      final response = await _apiClient.dio.post(
        '/users/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);

        if (loginResponse.token != null) {
          await _secureStorage.write(
            key: 'rider_auth_token',
            value: loginResponse.token!,
          );
        }
        return loginResponse;
      }
      return null;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Login failed';
      print("Login failed error: $errorMessage");
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'rider_auth_token');
  }
}
