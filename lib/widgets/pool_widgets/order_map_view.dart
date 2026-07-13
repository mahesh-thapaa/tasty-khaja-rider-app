import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:rider/const/app_colors.dart';

class OrderMapView extends StatelessWidget {
  final double latitude;
  final double longitude;

  const OrderMapView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(latitude, longitude),
            initialZoom: 14.5,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.rider',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(latitude, longitude),
                  width: 120.w,
                  height: 80.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(6.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor.withValues(
                                  alpha: 0.2,
                                ),
                                blurRadius: 4.r,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Delivery Location',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.shadowColor,
                                ),
                              ),
                              Text(
                                '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}',
                                style: TextStyle(
                                  fontSize: 7.sp,
                                  color: AppColors.navBarColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8.h,
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                          size: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
