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
    final locationPoint = LatLng(latitude, longitude);
    return Container(
      height: 180.h,
      width: double.infinity,
      color: AppColors.navBarColor,
      child: FlutterMap(
        options: MapOptions(initialCenter: locationPoint, initialZoom: 15.0),

        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: locationPoint,
                width: 40.w,
                height: 40.h,
                child: Icon(Icons.location_on, color: AppColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
