import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/leeds_models/info_models.dart';

class LeadItemCard extends StatefulWidget {
  final InfoModels lead;
  final void Function(InfoModels updatedLead)? onSave;

  const LeadItemCard({super.key, required this.lead, this.onSave});

  @override
  State<LeadItemCard> createState() => _LeadItemCardState();
}

class _LeadItemCardState extends State<LeadItemCard> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _orgController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(covariant LeadItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lead != oldWidget.lead && !_isEditing) {
      _initControllers();
    }
  }

  void _initControllers() {
    _nameController = TextEditingController(text: widget.lead.clientName);
    _orgController = TextEditingController(text: widget.lead.organization ?? '');
    _addressController = TextEditingController(text: widget.lead.address);
    _phoneController = TextEditingController(text: widget.lead.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _orgController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      return dateStr.substring(0, 10);
    } catch (_) {
      return dateStr;
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        _nameController.text = widget.lead.clientName;
        _orgController.text = widget.lead.organization ?? '';
        _addressController.text = widget.lead.address;
        _phoneController.text = widget.lead.phoneNumber;
      }
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = InfoModels(
      id: widget.lead.id,
      clientName: _nameController.text.trim(),
      organization: _orgController.text.trim(),
      address: _addressController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      status: widget.lead.status,
      rider: widget.lead.rider,
      riderName: widget.lead.riderName,
      createdAt: widget.lead.createdAt,
    );

    setState(() => _isEditing = false);
    widget.onSave?.call(updated);
  }

  void _cancel() {
    setState(() => _isEditing = false);
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF8A94A6),
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 3.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF1F2937)),
            validator: required
                ? (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '$label is required';
                    }
                    return null;
                  }
                : null,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: Icon(icon, size: 16.sp, color: AppColors.navBarColor.withValues(alpha: 0.7)),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.textColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: _isEditing
              ? AppColors.primaryColor.withValues(alpha: 0.5)
              : AppColors.shadowColor.withValues(alpha: 0.2),
          width: _isEditing ? 2.0 : 1.5,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.navBarColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    widget.lead.status.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.leadsColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: AppColors.navBarColor.withValues(alpha: 0.7),
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(widget.lead.createdAt),
                      style: TextStyle(
                        color: AppColors.navBarColor.withValues(alpha: 0.7),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: _toggleEdit,
                      child: Icon(
                        _isEditing ? Icons.close : Icons.edit_outlined,
                        color: _isEditing
                            ? AppColors.navBarColor
                            : AppColors.primaryColor,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8.h),

            if (_isEditing) ...[
              _buildEditableField(
                label: 'Client Name',
                controller: _nameController,
                icon: Icons.person_outline,
                required: true,
              ),
              _buildEditableField(
                label: 'Organization',
                controller: _orgController,
                icon: Icons.business_outlined,
              ),
              _buildEditableField(
                label: 'Address',
                controller: _addressController,
                icon: Icons.location_on_outlined,
                required: true,
              ),
              _buildEditableField(
                label: 'Phone Number',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                required: true,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.h,
                      child: ElevatedButton(
                        onPressed: _cancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navBarColor.withValues(alpha: 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.navBarColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: SizedBox(
                      height: 36.h,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text(
                widget.lead.clientName,
                style: TextStyle(
                  color: AppColors.shadowColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              Row(
                children: [
                  Icon(
                    Icons.business_outlined,
                    color: AppColors.navBarColor.withValues(alpha: 0.7),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.lead.organization ?? '',
                    style: TextStyle(
                      color: AppColors.navBarColor.withValues(alpha: 0.7),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6.h),

              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.navBarColor.withValues(alpha: 0.7),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.lead.address,
                    style: TextStyle(
                      color: AppColors.navBarColor.withValues(alpha: 0.7),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6.h),

              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    color: AppColors.navBarColor.withValues(alpha: 0.7),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.lead.phoneNumber,
                    style: TextStyle(
                      color: AppColors.navBarColor.withValues(alpha: 0.7),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
