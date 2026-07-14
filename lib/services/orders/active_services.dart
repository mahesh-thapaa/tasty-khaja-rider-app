import 'package:dio/dio.dart';
import 'package:rider/models/active_models/order_active_models.dart';
import 'package:rider/services/core/api_client.dart';

class ActiveService {
  final ApiClient _apiClient = ApiClient();

  Future<List<OrderActiveModels>> getMyOrders({
    String? status,
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'skip': skip,
        'limit': limit,
      };
      if (status != null) queryParams['status'] = status;

      final response = await _apiClient.dio.get(
        '/rider/orders/my',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> ordersList = responseData['data'];
          return ordersList
              .map((json) => OrderActiveModels.fromJson(json))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to load my orders';
      print("Fetch My Orders error: $errorMessage");
      throw Exception(errorMessage);
    }
  }
}
