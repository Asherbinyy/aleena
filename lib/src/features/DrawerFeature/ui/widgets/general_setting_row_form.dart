import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GeneralSettingRowForm extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  GeneralSettingRowForm({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontW: FW.semibold,
              fontSize: 16,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: KCMainBlack,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
