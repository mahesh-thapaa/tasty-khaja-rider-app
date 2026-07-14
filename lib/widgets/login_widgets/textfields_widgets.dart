import 'package:flutter/material.dart';
import 'package:rider/models/login_models/login_models.dart';



class TextfieldsWidgets extends StatefulWidget {
  final Function(LoginModels) onSubmitted;

  const TextfieldsWidgets({super.key, required this.onSubmitted});

  @override
  State<TextfieldsWidgets> createState() => _LoginFieldsContainerState();
}

class _LoginFieldsContainerState extends State<TextfieldsWidgets> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const Color labelAndIconColor = Color(0xFF5A4A42); // Warm dark brown
  static const Color fieldBackgroundColor = Color(0xFFF6F4F4); // Off-white/light warm grey
  static const Color hintTextColor = Color(0xFF8A939E); // Muted slate grey

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // 2. Instantiate your LoginModels when validation succeeds
      final loginData = LoginModels(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Pass the model back to your parent screen or authentication function
      widget.onSubmitted(loginData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Email Text Field ---
          const Text(
            'Email',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: labelAndIconColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: labelAndIconColor),
            decoration: _buildInputDecoration(
              hintText: 'Enter your email',
              prefixIcon: Icons.mail_outline,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),

          // --- Password Text Field ---
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: labelAndIconColor,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(color: labelAndIconColor),
            decoration: _buildInputDecoration(
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: labelAndIconColor,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),

          // Trigger submit button
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB91C1C),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to keep your styling clean and unified
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: hintTextColor,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: labelAndIconColor,
        size: 22,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fieldBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0), // Rounded pill styling
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(
          color: labelAndIconColor,
          width: 1.0,
        ),
      ),
    );
  }
}