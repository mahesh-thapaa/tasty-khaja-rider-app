import 'package:dio/dio.dart';
import 'package:rider/models/pool_models/order_models.dart';
import 'package:rider/services/core/api_client.dart';

class PoolServices {
  final ApiClient _apiClient = ApiClient();

  Future<List<Order>> getAvailableOrders() async {
    try {
      final response = await _apiClient.dio.get('/rider/orders/available');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> ordersList = responseData['data'];
          return ordersList.map((json) => Order.fromJson(json)).toList();
        }
      }
      return [];
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to load available orders';
      print("Fetch Orders error: $errorMessage");
      throw Exception(errorMessage);
    }
  }

}
