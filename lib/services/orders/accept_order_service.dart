import 'package:dio/dio.dart';
import 'package:rider/services/core/api_client.dart';

class AcceptOrderService {
  final ApiClient _apiClient = ApiClient();

  Future<void> acceptOrder(String orderId) async {
    try {
      final response = await _apiClient.dio.put('/rider/orders/$orderId/accept');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] != true) {
          throw Exception(responseData['message'] ?? 'Failed to accept order');
        }
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to accept order';
      print("Accept Order error: $errorMessage");
      throw Exception(errorMessage);
    }
  }
}
