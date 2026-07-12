import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';

class PoolScreen extends StatelessWidget {
  const PoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(topBarData: topBarData),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 5.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Orders",
                  style: TextStyle(
                    color: AppColors.shadowColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.sp),
                Text(
                  "Tap to accept and order",
                  style: TextStyle(
                    color: AppColors.navBarColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtonNavBar(currentIndex: 0),
    );
  }
}
