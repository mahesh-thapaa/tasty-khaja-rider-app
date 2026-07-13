import 'package:rider/models/pool_models/order_items_models.dart';

class OrderCartModels {
  final String orderID;
  final String paymentMethod;
  final String deliveryLocationName;
  final double distanceKm;
  final double latitude;
  final double longitude;
  final List<OrderItemsModels> items;
  final double subtotal;
  final double deliveryCharge;
  OrderCartModels({
    required this.deliveryCharge,
    required this.deliveryLocationName,
    required this.distanceKm,
    required this.items,
    required this.latitude,
    required this.longitude,
    required this.orderID,
    required this.paymentMethod,
    required this.subtotal,
  });
  double get totalToCollect => subtotal + deliveryCharge;
}
