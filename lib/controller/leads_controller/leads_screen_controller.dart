import 'package:flutter/foundation.dart';
import 'package:rider/models/leeds_models/info_models.dart';
import 'package:rider/services/leads/get_lead_services.dart';
import 'package:rider/services/leads/lead_service.dart';
import 'package:rider/services/leads/update_lead_services.dart';

class LeadsScreenController extends ChangeNotifier {
  bool _isFormVisible = false;
  bool _isSubmitting = false;
  bool _isLoading = true;
  String? _error;
  List<InfoModels> _leads = [];
  final LeadService _leadService = LeadService();
  final GetLeadServices _getLeadServices = GetLeadServices();
  final UpdateLeadServices _updateLeadServices = UpdateLeadServices();
  bool _disposed = false;

  bool get isFormVisible => _isFormVisible;
  bool get isSubmitting => _isSubmitting;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<InfoModels> get leads => _leads;

  void toggleForm() {
    _isFormVisible = !_isFormVisible;
    notifyListeners();
  }

  Future<void> fetchLeads() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final leads = await _getLeadServices.getLeads();
      if (_disposed) return;
      _leads = leads;
      _isLoading = false;
    } catch (e) {
      if (_disposed) return;
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
    }
    if (!_disposed) notifyListeners();
  }

  Future<String?> handleSubmit(InfoModels lead) async {
    _isSubmitting = true;
    notifyListeners();

    try {
      await _leadService.createLead(lead);
      if (_disposed) return null;
      _isFormVisible = false;
      _isSubmitting = false;
      if (!_disposed) notifyListeners();
      await fetchLeads();
      return null;
    } catch (e) {
      if (_disposed) return null;
      _isSubmitting = false;
      if (!_disposed) notifyListeners();
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> handleUpdate(InfoModels lead) async {
    _isSubmitting = true;
    notifyListeners();

    try {
      await _updateLeadServices.updateLead(lead);
      if (_disposed) return null;
      _isSubmitting = false;
      if (!_disposed) notifyListeners();
      await fetchLeads();
      return null;
    } catch (e) {
      if (_disposed) return null;
      _isSubmitting = false;
      if (!_disposed) notifyListeners();
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
