import 'package:rider/models/pool_models/order_items_models.dart';
import 'package:rider/models/pool_models/order_models.dart';

class OrderActiveModels {
  final String id;
  final String mongoId;
  final String paymentMethod;
  final String deliveryLocationName;
  final Coordinates coordinates;
  final String distance;
  final List<OrderItem> items;
  final double deliveryCharge;
  final String customerName;
  final String customerPhone;
  final String status;

  OrderActiveModels({
    required this.id,
    required this.mongoId,
    required this.paymentMethod,
    required this.deliveryLocationName,
    required this.coordinates,
    required this.distance,
    required this.items,
    required this.deliveryCharge,
    required this.customerName,
    required this.customerPhone,
    required this.status,
  });

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get total {
    return subtotal + deliveryCharge;
  }

  factory OrderActiveModels.fromJson(Map<String, dynamic> json) {
    final address = json['deliveryAddress'] ?? {};
    final addressLine = address['addressLine'] ?? '';
    final city = address['city'] ?? '';
    final fullAddress = addressLine.isNotEmpty && city.isNotEmpty
        ? '$addressLine, $city'
        : (addressLine.isNotEmpty ? addressLine : city);

    final user = json['user'] ?? {};

    final parsedItems = (json['items'] as List? ?? [])
        .map((item) => OrderItem.fromJson(item))
        .toList();

    return OrderActiveModels(
      id: json['orderId'] ?? json['_id'] ?? '',
      mongoId: json['_id'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'COD',
      deliveryLocationName: fullAddress,
      coordinates: Coordinates.fromJson(json['userLocation'] ?? {}),
      distance: '${json['distance'] ?? 0.0} km',
      items: parsedItems,
      deliveryCharge: (json['deliveryCharge'] as num?)?.toDouble() ?? 0.0,
      customerName: user['fullName'] ?? '',
      customerPhone: user['phone'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
