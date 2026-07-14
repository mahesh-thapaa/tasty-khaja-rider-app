import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/widgets/login_widgets/textfields_widgets.dart';

class LoginScree extends StatelessWidget {
  const LoginScree({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 600
        ? screenWidth * 0.9
        : math.min(500.0, screenWidth * 0.6).toDouble();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Center(
              child: Container(
                width: cardWidth,
                color: AppColors.paymentBorderColor,
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
                    TextfieldsWidgets(
                      onSubmitted: (loginData) {
                        // TODO: Implement login logic with loginData.email and loginData.password
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
