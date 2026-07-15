import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/controller/leads_controller/leads_screen_controller.dart';
import 'package:rider/models/leeds_models/info_models.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/widgets/leeds_widget.dart/info_widgets.dart';
import 'package:rider/widgets/leeds_widget.dart/leed_cart_widget.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  final _controller = LeadsScreenController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
    _controller.fetchLeads();
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(InfoModels lead) async {
    final error = await _controller.handleSubmit(lead);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? 'Lead created successfully'),
        backgroundColor: error != null
            ? AppColors.primaryColor
            : AppColors.paidColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Leads",
                            style: TextStyle(
                              color: AppColors.shadowColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Add potential corporate clients",
                            style: TextStyle(
                              color: AppColors.navBarColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _controller.toggleForm,
                        icon: Icon(
                          _controller.isFormVisible ? Icons.close : Icons.add,
                          color: AppColors.textColor,
                          size: 20.sp,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: _controller.isFormVisible
                              ? AppColors.primaryColor.withValues(alpha: 0.5)
                              : AppColors.primaryColor,
                          minimumSize: Size(38.w, 38.w),
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  if (_controller.isFormVisible) ...[
                    InfoWidgets(
                      onSubmit: _handleSubmit,
                      isSubmitting: _controller.isSubmitting,
                    ),
                    SizedBox(height: 20.h),
                  ],
                  if (_controller.isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                      ),
                    )
                  else if (_controller.error != null)
                    Center(
                      child: Column(
                        children: [
                          Text(
                            _controller.error!,
                            style: const TextStyle(
                              color: AppColors.shadowColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: _controller.fetchLeads,
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _controller.leads.length,
                      itemBuilder: (context, index) {
                        return LeadItemCard(lead: _controller.leads[index]);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtonNavBar(currentIndex: 2),
    );
  }
}
