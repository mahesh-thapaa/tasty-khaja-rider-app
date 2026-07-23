import 'package:rider/models/pool_models/order_items_models.dart';

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: (json['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Order {
  final String id;
  final String mongoId;
  final String paymentMethod;
  final String deliveryLocationName;
  final Coordinates coordinates;
  final String distance;
  final List<OrderItem> items;
  final double deliveryCharge;

  Order({
    required this.id,
    required this.mongoId,
    required this.paymentMethod,
    required this.deliveryLocationName,
    required this.coordinates,
    required this.distance,
    required this.items,
    required this.deliveryCharge,
  });

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get total {
    return subtotal + deliveryCharge;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final parsedItems = (json['items'] as List? ?? [])
        .map((item) => OrderItem.fromJson(item))
        .toList();

    final calculatedSubtotal = parsedItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    final apiTotal = (json['totalAmount'] as num?)?.toDouble() ?? 0.0;

    final calculatedDeliveryCharge = apiTotal > calculatedSubtotal
        ? apiTotal - calculatedSubtotal
        : 0.0;

    final addressData = json['deliveryAddress'] ?? {};
    final addressLine = addressData['addressLine'] ?? '';
    final city = addressData['city'] ?? '';
    final fullAddress = addressLine.isNotEmpty && city.isNotEmpty
        ? '$addressLine, $city'
        : (addressLine.isNotEmpty ? addressLine : city);

    return Order(
      id: json['orderId'] ?? json['_id'] ?? '',
      mongoId: json['_id'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'COD',
      deliveryLocationName: fullAddress,
      coordinates: Coordinates.fromJson(json['userLocation'] ?? {}),
      distance: '${json['distance'] ?? 0.0} km',
      items: parsedItems,
      deliveryCharge: calculatedDeliveryCharge,
    );
  }
}
