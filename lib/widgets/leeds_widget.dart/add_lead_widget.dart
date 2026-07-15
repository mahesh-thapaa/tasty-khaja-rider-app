import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/const/app_colors.dart';
import 'package:rider/widgets/leeds_widget.dart/info_widgets.dart';

class AddLeadDialog extends StatelessWidget {
  const AddLeadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4.h,
                    width: double.infinity,
                    color: AppColors.primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 16.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Column(
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close, color: AppColors.textColor),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: Size(36.w, 36.w),
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: InfoWidgets(
                        onSubmit: (lead) {
                          debugPrint(
                            'Lead submitted: ${lead.clientName}, ${lead.organization}, ${lead.address}, ${lead.phoneNumber}',
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
