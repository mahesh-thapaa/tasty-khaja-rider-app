import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/data/delivered_data/delivered_data.dart';
import 'package:rider/widgets/profile_widgets/deliverred_widgets/delivered_header.dart';
import 'package:rider/widgets/profile_widgets/deliverred_widgets/delivered_order.dart';

class DelivereWidgets extends StatelessWidget {
  const DelivereWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Container(
          padding: EdgeInsets.all(20.0.w),
          decoration: BoxDecoration(
            color: AppColors.textColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 15.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DeliveredHeader(count: mockOrders.length),
              SizedBox(height: 8.h),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: mockOrders.length,
                  itemBuilder: (context, index) {
                    return DeliveredOrder(order: mockOrders[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
