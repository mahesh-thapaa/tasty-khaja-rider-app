class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
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
}