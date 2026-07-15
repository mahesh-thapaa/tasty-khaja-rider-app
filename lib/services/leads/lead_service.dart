import 'package:dio/dio.dart';
import 'package:rider/models/leeds_models/info_models.dart';
import 'package:rider/services/core/api_client.dart';

class LeadService {
  final ApiClient _apiClient = ApiClient();

  Future<InfoModels> createLead(InfoModels lead) async {
    try {
      final response = await _apiClient.dio.post(
        '/rider/leads',
        data: lead.toJson(),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] == true) {
          return InfoModels.fromJson(responseData['data'] as Map<String, dynamic>);
        }
        throw Exception(responseData['message'] ?? 'Failed to create lead');
      }
      throw Exception('Failed to create lead');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to create lead';
      throw Exception(errorMessage);
    }
  }
}
