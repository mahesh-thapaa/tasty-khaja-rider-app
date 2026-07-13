import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/data/pool_data/order_data.dart';
import 'package:rider/models/pool_models/order_models.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/widgets/pool_widgets/empty_pool_widgets.dart';
import 'package:rider/widgets/pool_widgets/order_cart_widgets.dart';

class PoolScreen extends StatelessWidget {
  // Populate active pool list dynamically with the data sample model
  final List<Order> active = [sampleOrder];

  PoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(topBarData: topBarData),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
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
                    SizedBox(height: 2.h),
                    Text(
                      "Tap to accept an order",
                      style: TextStyle(
                        color: AppColors.navBarColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (active.isEmpty) ...[
                      const EmptyPoolWidgets(),
                    ] else ...[
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: active.length,
                        itemBuilder: (context, index) {
                          final order = active[index];
                          return OrderCardWidget(order: order);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtonNavBar(currentIndex: 0),
    );
  }
}
