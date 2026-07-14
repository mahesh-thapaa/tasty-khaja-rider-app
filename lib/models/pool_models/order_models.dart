import 'package:rider/models/pool_models/order_items_models.dart';

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: (json['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Order {
  final String id;
  final String paymentMethod;
  final String deliveryLocationName;
  final Coordinates coordinates;
  final String distance;
  final List<OrderItem> items;
  final double deliveryCharge;

  Order({
    required this.id,
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

    // Calculate subtotal from items
    final calculatedSubtotal = parsedItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    // Read total amount from backend response
    final apiTotal = (json['totalAmount'] as num?)?.toDouble() ?? 0.0;

    // Deduce delivery charge or fall back to 0.0 if not available
    final calculatedDeliveryCharge = apiTotal > calculatedSubtotal 
        ? apiTotal - calculatedSubtotal 
        : 0.0;

    // Parse location values
    final addressData = json['deliveryAddress'] ?? {};
    final addressLine = addressData['addressLine'] ?? '';
    final city = addressData['city'] ?? '';
    final fullAddress = addressLine.isNotEmpty && city.isNotEmpty
        ? '$addressLine, $city'
        : (addressLine.isNotEmpty ? addressLine : city);

    return Order(
      id: json['orderId'] ?? json['_id'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'COD', // Default value if not specified
      deliveryLocationName: fullAddress,
      coordinates: Coordinates.fromJson(json['userLocation'] ?? {}),
      distance: '${json['distance'] ?? 0.0} km', // Format distance as a display String
      items: parsedItems,
      deliveryCharge: calculatedDeliveryCharge,
    );
  }
}