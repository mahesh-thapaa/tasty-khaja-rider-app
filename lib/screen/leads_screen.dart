import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/screen/button_nav_bar.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

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
            padding: EdgeInsets.only(left: 22.w, top: 5.w, right: 22.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Leeds",
                      style: TextStyle(
                        color: AppColors.shadowColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Add potential cooporate clients",
                      style: TextStyle(
                        color: AppColors.navBarColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add, color: AppColors.textColor),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryColor.withValues(
                      alpha: 0.8,
                    ),
                    minimumSize: Size(38.w, 38.w),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtonNavBar(currentIndex: 2),
    );
  }
}
