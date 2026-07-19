import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/profile_models/profile_models.dart';

class PersonalInfo extends StatelessWidget {
  final ProfileModels profile;

  const PersonalInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.textColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "PERSONAL INFORMATION",
            style: TextStyle(
              color: AppColors.navBarColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 11.h),

          _buildInfoRow(
            icon: Icons.email_outlined,
            label: "EMAIL ADDRESS",
            value: profile.email,
            labelColor: AppColors.navBarColor,
            labelFontSize: 10.sp,

            valueColor: AppColors.shadowColor,
          ),
          SizedBox(height: 11.h),

          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: "PHONE NUMBER",
            value: profile.phone,
            labelColor: AppColors.navBarColor,
            valueColor: AppColors.shadowColor,

            labelFontSize: 10.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color labelColor,
    required Color valueColor,
    double? labelFontSize,
    // double? valueFontSize,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: const BoxDecoration(
            color: AppColors.textColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.navBarColor, size: 18.w),
        ),
        SizedBox(width: 16.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 14.sp,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
