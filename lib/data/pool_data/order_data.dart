import 'package:rider/models/pool_models/order_cart_models.dart';
import 'package:rider/models/pool_models/order_items_models.dart';

class OrderData {
  static List<OrderCartModels> getIncomingOrders() {
    return [
      OrderCartModels(
        deliveryCharge: 0.0,
        deliveryLocationName: "Amarsingh Chowk",
        distanceKm: 3.4,
        items: [
          OrderItemsModels(name: "Cheese Aslu Chop", price: 180.0, quantity: 1),
        ],
        latitude: 28.2105,
        longitude: 83.9912,
        orderID: "CK-1093",
        paymentMethod: "COD",
        subtotal: 360.0,
      ),
    ];
  }
}
