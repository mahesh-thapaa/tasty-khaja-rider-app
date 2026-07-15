import 'package:dio/dio.dart';
import 'package:rider/models/leeds_models/info_models.dart';
import 'package:rider/services/core/api_client.dart';

class GetLeadServices {
  final ApiClient _apiClient = ApiClient();

  Future<List<InfoModels>> getLeads() async {
    try {
      final response = await _apiClient.dio.get('/rider/leads');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] == true) {
          final List<dynamic> data = responseData['data'] as List<dynamic>;
          return data.map((e) => InfoModels.fromJson(e as Map<String, dynamic>)).toList();
        }
        throw Exception(responseData['message'] ?? 'Failed to fetch leads');
      }
      throw Exception('Failed to fetch leads');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to fetch leads';
      throw Exception(errorMessage);
    }
  }
}
