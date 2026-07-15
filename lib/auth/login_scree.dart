import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/login_models/login_models.dart';
import 'package:rider/models/login_models/login_request_models.dart';
import 'package:rider/screen/pool_screen.dart';
import 'package:rider/services/core/auth_services.dart';
import 'package:rider/widgets/login_widgets/textfields_widgets.dart';

class LoginScree extends StatefulWidget {
  const LoginScree({super.key});

  @override
  State<LoginScree> createState() => _LoginScreeState();
}

class _LoginScreeState extends State<LoginScree> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _onLoginSubmitted(LoginModels request) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.loginRider(
        LoginRequestModel(email: request.email, password: request.password),
      );

      setState(() {
        _isLoading = false;
      });

      if (response != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Logged in successfully'),
            backgroundColor: AppColors.paidColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PoolScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } else {
        _showError('Login failed. Please check your credentials.');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      _showError(error.toString().replaceAll('Exception: ', ''));
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 600
        ? screenWidth * 0.9
        : math.min(500.0, screenWidth * 0.6).toDouble();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Center(
                  child: Container(
                    width: cardWidth,
                    color: AppColors.containerColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tasty Khaja",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "    Delicious moments delivered to your \ndoorstep. Join our food community today ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.navBarColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        TextfieldsWidgets(onSubmitted: _onLoginSubmitted),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (_isLoading)
              Container(
                color: AppColors.shadowColor.withValues(alpha: 0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
