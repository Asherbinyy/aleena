import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';
import 'package:get/get.dart';

class ButtonRate extends StatelessWidget {
  final VoidCallback? onTap;


  ButtonRate({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??(){},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: KCSeconary
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h
          ),
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.white,size: 10.h,),
              4.0.ESW(),
              CustomText(
                text: 'rate_'.tr,
                color: Colors.white,
                fontW: FW.medium,
                fontSize: 11,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
