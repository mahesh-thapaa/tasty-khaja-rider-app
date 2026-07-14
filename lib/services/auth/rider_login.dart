import 'package:dio/dio.dart';
import 'package:rider/services/core/api_client.dart';

class RiderLogin {
  final ApiClient _apiClient = ApiClient();

  Future<void> getAssignedOrders() async {
    try {
      final response = await _apiClient.dio.get('/riders/orders');

      if (response.statusCode == 200) {
        print("Orders fetched successfully: ${response.data}");
      }
    } on DioException catch (e) {
      print("Error fetching orders: ${e.message}");
    }
  }
}
