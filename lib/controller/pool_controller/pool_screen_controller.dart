import 'package:flutter/foundation.dart';
import 'package:rider/models/pool_models/order_models.dart';
import 'package:rider/services/orders/accept_order_service.dart';
import 'package:rider/services/orders/pool_services.dart';

class PoolScreenController extends ChangeNotifier {
  final PoolServices _poolServices = PoolServices();
  final AcceptOrderService _acceptOrderService = AcceptOrderService();
  List<Order> _activeOrders = [];
  bool _isLoading = true;
  String? _errorMessage;
  bool _disposed = false;

  List<Order> get activeOrders => _activeOrders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final orders = await _poolServices.getAvailableOrders();
      if (_disposed) return;
      _activeOrders = orders;
      _isLoading = false;
    } catch (e) {
      if (_disposed) return;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
    }
    if (!_disposed) notifyListeners();
  }

  Future<String?> acceptOrder(Order order) async {
    try {
      await _acceptOrderService.acceptOrder(order.mongoId);
      await fetchOrders();
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
