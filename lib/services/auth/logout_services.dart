import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rider/services/core/api_client.dart';

class LogoutServices {
  final ApiClient _apiClient = ApiClient();
  final _secureStorage = const FlutterSecureStorage();

  Future<void> logout() async {
    try {
      await _apiClient.dio.post('/users/logout');
    } on DioException {
    } finally {
      await _secureStorage.delete(key: 'rider_auth_token');
    }
  }
}
