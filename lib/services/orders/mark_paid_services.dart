import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rider/services/core/api_client.dart';

class MarkPaidService {
  final ApiClient _apiClient = ApiClient();

  Future<void> markOrderPaid(String orderId, {required String paymentMethod}) async {
    try {
      final response = await _apiClient.dio.put(
        '/rider/orders/$orderId/paid',
        data: {'paymentMethod': paymentMethod},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] != true) {
          throw Exception(responseData['message'] ?? 'Failed to mark as paid');
        }
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to mark as paid';
      debugPrint("Mark Paid error: $errorMessage");
      throw Exception(errorMessage);
    }
  }
}
