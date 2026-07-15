import 'package:rider/services/core/api_client.dart';

class LogoutServices {
  final ApiClient _apiClient = ApiClient();

  Future<void> logout() async {
    try {
      await _apiClient.dio.post('/users/logout');
    } finally {
      await ApiClient.secureStorage.delete(key: 'rider_auth_token');
    }
  }
}
