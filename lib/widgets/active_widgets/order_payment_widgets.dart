import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/components/map_components/map_view.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/active_models/order_active_models.dart';

class OrderPaymentWidgets extends StatefulWidget {
  final OrderActiveModels order;
  final bool isPaid;
  final ValueChanged<String>? onMarkPaid;
  final VoidCallback? onMarkDelivered;

  const OrderPaymentWidgets({
    super.key,
    required this.order,
    required this.isPaid,
    this.onMarkPaid,
    this.onMarkDelivered,
  });

  @override
  State<OrderPaymentWidgets> createState() => _OrderPaymentWidgetsState();
}

class _OrderPaymentWidgetsState extends State<OrderPaymentWidgets> {
  String selectedMethod = 'COD';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.navBarColor.withValues(alpha: 0.15),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER ID',
                    style: TextStyle(
                      color: AppColors.navBarColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '#${widget.order.id}',
                    style: TextStyle(
                      color: AppColors.shadowColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'TOTAL TO COLLECT',
                    style: TextStyle(
                      color: AppColors.navBarColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Rs. ${widget.order.total.toInt()}',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: AppColors.navBarColor.withValues(alpha: 0.3),
            height: 32,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MapView(
                    latitude: widget.order.coordinates.latitude,
                    longitude: widget.order.coordinates.longitude,
                  ),
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    icon: Icons.person_outline,
                    iconBgColor: AppColors.containerColor,
                    iconColor: AppColors.navBarColor,
                    label: 'CUSTOMER',
                    value: widget.order.customerName,
                  ),
                  SizedBox(height: 5.h),
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    iconBgColor: AppColors.containerColor,
                    iconColor: AppColors.leadsColor,
                    label: 'PHONE',
                    value: widget.order.customerPhone,
                  ),
                  SizedBox(height: 5.h),
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    iconBgColor: AppColors.containerColor,
                    iconColor: AppColors.primaryColor,
                    label: 'ADDRESS',
                    value: widget.order.deliveryLocationName,
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.navBarColor.withValues(alpha: 0.1),
                  ),
                ),
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORDER ITEMS',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navBarColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 9.h),
                    ...widget.order.items.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${item.quantity}x  ${item.name}',
                              style: TextStyle(
                                color: AppColors.shadowColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rs. ${item.price.toInt()}',
                              style: TextStyle(
                                color: AppColors.shadowColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.navBarColor.withValues(alpha: 0.3),
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GRAND TOTAL',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navBarColor,
                          ),
                        ),
                        Text(
                          'Rs. ${widget.order.total.toInt()}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (!widget.isPaid) ...[
                SizedBox(height: 16.h),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.navBarColor.withValues(alpha: 0.1),
                    ),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT PAYMENT METHOD',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navBarColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(child: _buildPaymentButton('COD')),
                          SizedBox(width: 12.w),
                          Expanded(child: _buildPaymentButton('Online')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              if (!widget.isPaid) ...[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget.onMarkPaid?.call(selectedMethod),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.paidColor,
                      foregroundColor: AppColors.textColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text(
                      'Mark Paid',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
              ],
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onMarkDelivered,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.textColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text(
                    'Mark Delivered',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(String method) {
    final isSelected = selectedMethod == method;
    final Color selectedColor = method == 'Online'
        ? AppColors.leadsColor
        : AppColors.primaryColor;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = method),
      child: Container(
        height: 35.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppColors.navBarColor.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          method == 'COD' ? 'CASH' : method.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.navBarColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.navBarColor,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.shadowColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
