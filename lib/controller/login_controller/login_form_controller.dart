import 'package:flutter/material.dart';
import 'package:rider/models/login_models/login_models.dart';

class LoginFormController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  LoginModels? submit() {
    if (formKey.currentState!.validate()) {
      return LoginModels(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
