import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Your existing imports
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/data/active_data/order_payment_data.dart';
import 'package:rider/models/active_models/order_active_models.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/widgets/active_widgets/empty_active_widgets.dart';
import 'package:rider/widgets/active_widgets/order_payment_widgets.dart';

class ActiveScreens extends StatelessWidget {
  // Populate the active list with the sampleOrder instance to trigger the else state
  final List<OrderActiveModels> active = [sampleOrder];

  ActiveScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(topBarData: topBarData),

          // SizedBox(height: 8.h),
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
                    Text(
                      "Tap to accept an order",
                      style: TextStyle(
                        color: AppColors.navBarColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (active.isEmpty) ...[
                      const EmptyActiveWidgets(),
                    ] else ...[
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: active.length,
                        itemBuilder: (context, index) {
                          final order = active[index];
                          return OrderPaymentWidgets(order: order);
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
      bottomNavigationBar: ButtonNavBar(currentIndex: 1),
    );
  }
}
