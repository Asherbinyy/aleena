import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';

class ButtonCircle extends StatelessWidget {
  final VoidCallback? onTap;
  final String? icon;

  ButtonCircle({this.onTap,this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??(){

      },
      child: Container(
        height: 27.h,
        width: 27.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: KCSeconary,
        ),
        child: Center(
          child: Image.asset(
            'assets/icons/$icon',
            height: 10.83.h,
          ),
        ),
      ),
    );
  }
}
