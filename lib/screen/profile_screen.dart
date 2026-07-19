import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/auth/login_scree.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/controller/profile_controller/profile_screen_controller.dart';
import 'package:rider/data/profile_data/profile_data.dart';
import 'package:rider/screen/button_nav_bar.dart';
import 'package:rider/data/pool_data/top_bar_data.dart';
import 'package:rider/components/top_bar_components/top_bar.dart';
import 'package:rider/widgets/profile_widgets/deliverred_widgets/delivered_widgets.dart';
import 'package:rider/widgets/profile_widgets/personal_info.dart';
import 'package:rider/widgets/profile_widgets/profile_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = ProfileScreenController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    final error = await _controller.handleLogout();
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Logged out successfully'),
          backgroundColor: AppColors.paidColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScree()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Column(
        children: [
          TopBar(topBarData: topBarData),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  ProfileSection(profile: profileData),
                  SizedBox(height: 10.h),
                  PersonalInfo(profile: profileData),
                  DelivereWidgets(),
                  SizedBox(height: 16.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: InkWell(
                      onTap: _controller.isLoggingOut ? null : _handleLogout,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.3,
                            ),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _controller.isLoggingOut
                              ? [
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Logging out...",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                              : [
                                  // Standard button contents
                                  Icon(
                                    Icons.logout,
                                    color: AppColors.primaryColor,
                                    size: 20.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtonNavBar(currentIndex: 3),
    );
  }
}
