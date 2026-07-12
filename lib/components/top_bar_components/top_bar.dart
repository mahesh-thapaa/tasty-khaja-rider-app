import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/pool_models/top_bar_models.dart';

class TopBar extends StatelessWidget {
  final TopBarModels topBarData;
  const TopBar({super.key, required this.topBarData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 90.h,
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 32.h,
            bottom: 8.h,
          ),
          decoration: BoxDecoration(color: AppColors.primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RIDER APP",
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    topBarData.userName.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: AppColors.textColor,
                  size: 20.w,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.textColor.withValues(alpha: 0.15),
                  minimumSize: Size(38.w, 38.w),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
