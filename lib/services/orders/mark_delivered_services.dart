import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rider/services/core/api_client.dart';

class MarkDeliveredService {
  final ApiClient _apiClient = ApiClient();

  Future<void> markOrderDelivered(String orderId) async {
    try {
      final response = await _apiClient.dio.put(
        '/rider/orders/$orderId/deliver',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] != true) {
          throw Exception(responseData['message'] ?? 'Failed to mark as delivered');
        }
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to mark as delivered';
      debugPrint("Mark Delivered error: $errorMessage");
      throw Exception(errorMessage);
    }
  }
}
