import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/models/leeds_models/info_models.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/services/leads/get_lead_services.dart';
import 'package:rider/services/leads/lead_service.dart';
import 'package:rider/widgets/leeds_widget.dart/info_widgets.dart';
import 'package:rider/widgets/leeds_widget.dart/leed_cart_widget.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  bool _isFormVisible = false;
  bool _isSubmitting = false;
  bool _isLoading = true;
  String? _error;
  List<InfoModels> _leads = [];
  final LeadService _leadService = LeadService();
  final GetLeadServices _getLeadServices = GetLeadServices();

  @override
  void initState() {
    super.initState();
    _fetchLeads();
  }

  Future<void> _fetchLeads() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final leads = await _getLeadServices.getLeads();
      if (!mounted) return;
      setState(() {
        _leads = leads;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSubmit(lead) async {
    setState(() => _isSubmitting = true);
    try {
      await _leadService.createLead(lead);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Lead created successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _isFormVisible = false;
        _isSubmitting = false;
      });
      _fetchLeads();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isSubmitting = false);
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
                        onPressed: () {
                          setState(() {
                            _isFormVisible = !_isFormVisible;
                          });
                        },
                        icon: Icon(
                          _isFormVisible ? Icons.close : Icons.add,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: _isFormVisible
                              ?  AppColors.primaryColor.withValues(alpha: 0.5)
                              : AppColors.primaryColor,
                          minimumSize: Size(38.w, 38.w),
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  if (_isFormVisible) ...[
                    InfoWidgets(
                      onSubmit: _handleSubmit,
                      isSubmitting: _isSubmitting,
                    ),
                    SizedBox(height: 20.h),
                  ],
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_error != null)
                    Center(
                      child: Column(
                        children: [
                          Text(_error!, style: const TextStyle(color: Colors.red)),
                          SizedBox(height: 8.h),
                          TextButton(onPressed: _fetchLeads, child: const Text('Retry')),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _leads.length,
                      itemBuilder: (context, index) {
                        return LeadItemCard(lead: _leads[index]);
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
