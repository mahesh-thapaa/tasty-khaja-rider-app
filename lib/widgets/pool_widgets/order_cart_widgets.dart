import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/pool_models/order_models.dart';
import 'order_map_view.dart';

class OrderCardWidget extends StatelessWidget {
  final Order order;

  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.navBarColor.withValues(alpha: 0.15),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${order.id}',
                style: TextStyle(
                  color: AppColors.shadowColor.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.paymentBorderColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  order.paymentMethod,
                  style: TextStyle(
                    color: AppColors.paymentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          OrderMapView(
            latitude: order.coordinates.latitude,
            longitude: order.coordinates.longitude,
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h, right: 6.w),
                child: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.deliveryLocationName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.shadowColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${order.distance} FROM KITCHEN',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.navBarColor.withValues(alpha: 0.15),
              ),
            ),
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORDER ITEMS',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.shadowColor,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                ...order.items.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${item.quantity}x ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.shadowColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                              TextSpan(
                                text: item.name,
                                style: TextStyle(
                                  color: AppColors.navBarColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Rs. ${item.price.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.shadowColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Color(0xFFE2E8F0), height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUBTOTAL',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navBarColor,
                      ),
                    ),
                    Text(
                      'Rs. ${order.subtotal.toInt()}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navBarColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DELIVERY CHARGE',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      'Rs. ${order.deliveryCharge.toInt()}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.navBarColor.withValues(alpha: 0.15),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL TO COLLECT',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      'Rs. ${order.total.toInt()}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.shadowColor,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.textColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Accept Order',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(Icons.arrow_forward, size: 14.sp),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
