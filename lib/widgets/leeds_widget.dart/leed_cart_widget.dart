import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/leeds_models/info_models.dart';

class LeadItemCard extends StatelessWidget {
  final InfoModels lead;

  const LeadItemCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.shadowColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.navBarColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  lead.status.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.leadsColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: AppColors.navBarColor.withValues(alpha: 0.7),
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    lead.date,
                    style: TextStyle(
                      color: AppColors.navBarColor.withValues(alpha: 0.7),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8.h),

          Text(
            lead.name,
            style: TextStyle(
              color: AppColors.shadowColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Icon(
                Icons.business_outlined,
                color: AppColors.navBarColor.withValues(alpha: 0.7),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                lead.organization,
                style: TextStyle(
                  color: AppColors.navBarColor.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // Row 4: Address Item
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.navBarColor.withValues(alpha: 0.7),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                lead.address,
                style: TextStyle(
                  color: AppColors.navBarColor.withValues(alpha: 0.7),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
