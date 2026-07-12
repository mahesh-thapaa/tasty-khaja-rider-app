import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/profile_models/profile_models.dart';

class ProfileSection extends StatelessWidget {
  final ProfileModels profile;
  const ProfileSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final String initial = profile.name.trim().isNotEmpty
        ? profile.name.trim()[0].toUpperCase()
        : '?';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            initial,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          profile.name,
          style: TextStyle(
            color: AppColors.shadowColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.2, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Text(
            profile.role.toUpperCase(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          
        ),
      ],
    );
  }
}
