import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Your existing imports
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/active_models/order_active_models.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/services/orders/active_services.dart';
import 'package:rider/widgets/active_widgets/empty_active_widgets.dart';
import 'package:rider/widgets/active_widgets/order_payment_widgets.dart';

class ActiveScreens extends StatefulWidget {
  const ActiveScreens({super.key});

  @override
  State<ActiveScreens> createState() => _ActiveScreensState();
}

class _ActiveScreensState extends State<ActiveScreens> {
  final ActiveService _activeService = ActiveService();
  List<OrderActiveModels> _active = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final orders = await _activeService.getMyOrders();
      setState(() {
        _active = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
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
              onRefresh: _fetchOrders,
              color: AppColors.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
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
    if (_isLoading) {
      return SizedBox(
        height: 200.h,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return SizedBox(
        height: 200.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: _fetchOrders,
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

    if (_active.isEmpty) {
      return const EmptyActiveWidgets();
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _active.length,
      itemBuilder: (context, index) {
        final order = _active[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: OrderPaymentWidgets(order: order),
        );
      },
    );
  }
}
