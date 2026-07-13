import 'package:flutter/material.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/screen/button_nav_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/widgets/active_widgets/empty_active_widgets.dart';

class ActiveScreens extends StatelessWidget {
  final List<dynamic> active = [];
  ActiveScreens({super.key});

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
                  "Tap to accept an order",
                  style: TextStyle(
                    color: AppColors.navBarColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                if (active.isEmpty) ...[
                  const EmptyActiveWidgets(),
                ] else ...[
                  // SizedBox(height: 10.h),
                  // OrderMapView(latitude: 28.2105, longitude: 83.9912),
                  // SizedBox(height: 10.h),

                  // OrderCartWidgets(orders:  )
                ],
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: ButtonNavBar(currentIndex: 1),
    );
  }
}
