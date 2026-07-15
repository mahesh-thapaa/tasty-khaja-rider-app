import 'package:dio/dio.dart';
import 'package:rider/models/login_models/login_request_models.dart';
import 'package:rider/models/login_models/login_response_models.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponseModel?> loginRider(LoginRequestModel request) async {
    try {
      final response = await _apiClient.dio.post(
        '/users/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        String? token;
        final setCookie = response.headers.value('set-cookie');
        if (setCookie != null) {
          final match = RegExp(r'token=([^;]+)').firstMatch(setCookie);
          if (match != null) {
            token = match.group(1);
          }
        }

        token ??= response.data['token'] as String?;

        if (token != null) {
          await ApiClient.secureStorage.write(
            key: 'rider_auth_token',
            value: token,
          );
        }

        final loginResponse = LoginResponseModel.fromJson(response.data);
        return loginResponse;
      }
      return null;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Login failed';
      throw Exception(errorMessage);
    }
  }
}
