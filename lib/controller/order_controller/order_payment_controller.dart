import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderPaymentController extends ChangeNotifier {
  String _selectedMethod = 'COD';

  String get selectedMethod => _selectedMethod;

  void selectMethod(String method) {
    _selectedMethod = method;
    notifyListeners();
  }
}
