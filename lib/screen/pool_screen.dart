import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/controller/pool_controller/pool_screen_controller.dart';
import 'package:rider/models/pool_models/order_models.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/widgets/pool_widgets/empty_pool_widgets.dart';
import 'package:rider/widgets/pool_widgets/order_cart_widgets.dart';

class PoolScreen extends StatefulWidget {
  const PoolScreen({super.key});

  @override
  State<PoolScreen> createState() => _PoolScreenState();
}

class _PoolScreenState extends State<PoolScreen> {
  final _controller = PoolScreenController();

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

  Future<void> _acceptOrder(Order order) async {
    final error = await _controller.acceptOrder(order);
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Order accepted!'),
          backgroundColor: AppColors.paidColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
    }
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
                      SizedBox(height: 10.h),
                      _buildBodyContent(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtonNavBar(currentIndex: 0),
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

    if (_controller.activeOrders.isEmpty) {
      return const EmptyPoolWidgets();
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _controller.activeOrders.length,
      itemBuilder: (context, index) {
        final order = _controller.activeOrders[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: OrderCardWidget(
            order: order,
            onAccept: () => _acceptOrder(order),
          ),
        );
      },
    );
  }
}
