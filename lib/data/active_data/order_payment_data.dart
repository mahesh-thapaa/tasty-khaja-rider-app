import 'package:rider/models/active_models/order_active_models.dart';
import 'package:rider/models/pool_models/order_items_models.dart';
import 'package:rider/models/pool_models/order_models.dart';
final sampleOrder = OrderActiveModels(
  id: 'CK-1001',
  paymentMethod: 'CASH', // Default initial selection state
  deliveryLocationName: 'Amarsingh chowk,',
  coordinates: Coordinates(latitude: 28.2108, longitude: 83.9835),
  distance: '3.4 KM',
  customerName: 'Mahesh Thapa',
  customerPhone: '9819198551',
  items: [
    OrderItem(name: 'Prawn rice (Full)', quantity: 1, price: 180.0),
  ],
  deliveryCharge: 0.0,
);