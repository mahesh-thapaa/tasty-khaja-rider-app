import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/models/leeds_models.dart/info_models.dart';

class InfoWidgets extends StatefulWidget {
  final void Function(InfoModels lead)? onSubmit;

  const InfoWidgets({super.key, this.onSubmit});

  @override
  State<InfoWidgets> createState() => _InfoWidgetsState();
}

class _InfoWidgetsState extends State<InfoWidgets> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    organizationController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submitLead() {
    if (!_formKey.currentState!.validate()) return;

    final lead = InfoModels(
      name: nameController.text.trim(),
      organization: organizationController.text.trim(),
      address: addressController.text.trim(),
      phoneNumber: phoneController.text.trim(),
    );

    if (widget.onSubmit != null) {
      widget.onSubmit!(lead);
    }
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8A94A6),
                  letterSpacing: 0.5,
                ),
              ),
              if (required) ...[
                SizedBox(width: 4.w),
                Text(
                  "*",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8A94A6),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 4.h),
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
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 10.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(
              label: 'Client Name',
              hint: 'E.g. John Doe',
              controller: nameController,
              required: true,
            ),
            _buildField(
              label: 'Organization',
              hint: 'E.g. Tech Solutions Inc',
              controller: organizationController,
            ),
            _buildField(
              label: 'Address',
              hint: 'E.g. 123 Main St, New Baneshwor',
              controller: addressController,
              required: true,
            ),
            _buildField(
              label: 'Phone Number',
              hint: '98XXXXXXXX',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              required: true,
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: double.infinity,
              height: 42.h,
              child: ElevatedButton(
                onPressed: _submitLead,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8F1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Submit Lead',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
