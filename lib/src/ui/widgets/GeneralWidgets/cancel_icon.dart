import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CancelIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Get.back();},
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(777.r),
          color: KCMain.withOpacity(0.10),
        ),
        child: Icon(Icons.close,color: KCMain,size: 20.w,),
      ),
    );
  }
}
