import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/controller/active_controller/active_screen_controller.dart';
import 'package:rider/models/active_models/order_active_models.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/widgets/active_widgets/empty_active_widgets.dart';
import 'package:rider/widgets/active_widgets/order_payment_widgets.dart';

class ActiveScreens extends StatefulWidget {
  const ActiveScreens({super.key});

  @override
  State<ActiveScreens> createState() => _ActiveScreensState();
}

class _ActiveScreensState extends State<ActiveScreens> {
  final _controller = ActiveScreenController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
    _controller.fetchOrders();
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _markPaid(OrderActiveModels order, String paymentMethod) async {
    final error = await _controller.markPaid(order, paymentMethod);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? 'Payment received'),
        backgroundColor: error != null ? AppColors.primaryColor : AppColors.paidColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  Future<void> _markDelivered(OrderActiveModels order) async {
    final error = await _controller.markDelivered(order);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? 'Order delivered'),
        backgroundColor: error != null ? AppColors.primaryColor : AppColors.paidColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(topBarData: topBarData),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _controller.fetchOrders,
              color: AppColors.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 5.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Orders",
                        style: TextStyle(
                          color: AppColors.shadowColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Your assigned and completed orders",
                        style: TextStyle(
                          color: AppColors.navBarColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildBodyContent(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ButtonNavBar(currentIndex: 1),
    );
  }

  Widget _buildBodyContent() {
    if (_controller.isLoading) {
      return SizedBox(
        height: 200.h,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      );
    }

    if (_controller.errorMessage != null) {
      return SizedBox(
        height: 200.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _controller.errorMessage!,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: _controller.fetchOrders,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(color: AppColors.textColor),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_controller.active.isEmpty) {
      return const EmptyActiveWidgets();
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _controller.active.length,
      itemBuilder: (context, index) {
        final order = _controller.active[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: OrderPaymentWidgets(
            order: order,
            isPaid: _controller.paidOrderIds.contains(order.mongoId),
            onMarkPaid: (method) => _markPaid(order, method),
            onMarkDelivered: () => _markDelivered(order),
          ),
        );
      },
    );
  }
}
