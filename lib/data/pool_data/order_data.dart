import 'package:rider/models/pool_models/order_items_models.dart';
import 'package:rider/models/pool_models/order_models.dart';

final sampleOrder = Order(
  id: 'CK-1001',
  paymentMethod: 'COD',
  deliveryLocationName: 'Amarsingh chowk',
  coordinates: Coordinates(latitude: 28.2108, longitude: 83.9835),
  distance: '3.4 KM',
  items: [OrderItem(name: 'Prawn rice (Full)', quantity: 1, price: 180.0)],
  deliveryCharge: 0.0,
);
