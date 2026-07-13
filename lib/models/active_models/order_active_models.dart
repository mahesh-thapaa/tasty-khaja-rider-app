import 'package:rider/models/pool_models/order_items_models.dart';
import 'package:rider/models/pool_models/order_models.dart';

class OrderActiveModels {
  final String id;
  final String paymentMethod;
  final String deliveryLocationName;
  final Coordinates coordinates;
  final String distance;
  final List<OrderItem> items;
  final double deliveryCharge;
  final String customerName;
  final String customerPhone;

  OrderActiveModels({
    required this.id,
    required this.paymentMethod,
    required this.deliveryLocationName,
    required this.coordinates,
    required this.distance,
    required this.items,
    required this.deliveryCharge,
    required this.customerName,
    required this.customerPhone,
  });

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get total {
    return subtotal + deliveryCharge;
  }
}
