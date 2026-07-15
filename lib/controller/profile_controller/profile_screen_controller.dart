import 'package:flutter/foundation.dart';
import 'package:rider/services/auth/logout_services.dart';

class ProfileScreenController extends ChangeNotifier {
  final LogoutServices _logoutServices = LogoutServices();
  bool _isLoggingOut = false;
  bool _disposed = false;

  bool get isLoggingOut => _isLoggingOut;

  Future<String?> handleLogout() async {
    _isLoggingOut = true;
    notifyListeners();

    try {
      await _logoutServices.logout();
      if (_disposed) return null;
      _isLoggingOut = false;
      if (!_disposed) notifyListeners();
      return null;
    } catch (e) {
      if (_disposed) return null;
      _isLoggingOut = false;
      if (!_disposed) notifyListeners();
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
