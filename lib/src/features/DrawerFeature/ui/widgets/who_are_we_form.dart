
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class WohAreWeForm extends StatelessWidget {
  final String questions;
  final String answer;
  WohAreWeForm({required this.questions, required this.answer});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
          color: KCBlueMenu.withOpacity(0.04),
           ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: CustomText(
                    text: questions,
                    fontW: FW.semibold,
                    fontSize: 12,
                    color: KCBlueMenu,
                  ),
                ),

              ],
            ),
            16.0.ESH(),
            Container(
              padding: EdgeInsets.only(left: 32.w),
              width: double.infinity,
              child: CustomText(
                text: answer,
                fontW: FW.semibold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
