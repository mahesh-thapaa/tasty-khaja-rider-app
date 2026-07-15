import 'package:flutter/foundation.dart';
import 'package:rider/models/active_models/order_active_models.dart';
import 'package:rider/services/orders/active_services.dart';
import 'package:rider/services/orders/mark_delivered_services.dart';
import 'package:rider/services/orders/mark_paid_services.dart';

class ActiveScreenController extends ChangeNotifier {
  final ActiveService _activeService = ActiveService();
  final MarkPaidService _markPaidService = MarkPaidService();
  final MarkDeliveredService _markDeliveredService = MarkDeliveredService();
  List<OrderActiveModels> _active = [];
  bool _isLoading = true;
  String? _errorMessage;
  final Set<String> _paidOrderIds = {};
  bool _disposed = false;

  List<OrderActiveModels> get active => _active;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Set<String> get paidOrderIds => _paidOrderIds;

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final orders = await _activeService.getMyOrders();
      if (_disposed) return;
      _active = orders;
      _isLoading = false;
    } catch (e) {
      if (_disposed) return;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
    }
    if (!_disposed) notifyListeners();
  }

  Future<String?> markPaid(OrderActiveModels order, String paymentMethod) async {
    try {
      await _markPaidService.markOrderPaid(
        order.mongoId,
        paymentMethod: paymentMethod,
      );
      if (_disposed) return null;
      _paidOrderIds.add(order.mongoId);
      if (!_disposed) notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> markDelivered(OrderActiveModels order) async {
    try {
      await _markDeliveredService.markOrderDelivered(order.mongoId);
      if (_disposed) return null;
      _active.removeWhere((o) => o.mongoId == order.mongoId);
      if (!_disposed) notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
