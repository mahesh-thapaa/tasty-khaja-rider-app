import 'package:dio/dio.dart';
import 'package:rider/models/leeds_models/info_models.dart';
import 'package:rider/services/core/api_client.dart';

class UpdateLeadServices {
  final ApiClient _apiClient = ApiClient();

  Future<InfoModels> updateLead(InfoModels lead) async {
    try {
      final body = lead.toJson()..remove('_id');
      final response = await _apiClient.dio.put(
        '/rider/leads/${lead.id}',
        data: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['success'] == true) {
          return InfoModels.fromJson(
            responseData['data'] as Map<String, dynamic>,
          );
        }
        throw Exception(responseData['message'] ?? 'Failed to update lead');
      }
      throw Exception('Failed to update lead');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to update lead';
      throw Exception(errorMessage);
    }
  }
}
