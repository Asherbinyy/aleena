
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleCardOrder extends StatelessWidget {
  final String? title;
  final String? subtitle;
  TitleCardOrder({this.title=' ', this.subtitle=' '});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints:BoxConstraints(maxWidth: 60.w),
          // width: 32.w,
          // color: Colors.red,
          child: CustomText(
            text: title,
            fontW: FW.light,
            color: KCDarkGrey,
            // overflow: true,
            fontSize: 11,
          ),
        ),
        Container(
          constraints:BoxConstraints(maxWidth: 190.w),
          // width: 178.w,
          // color: Colors.blue,
          child: CustomText(
            text: subtitle,
            fontW: FW.medium,
            color: KCDarkGrey,
            // overflow: true,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
