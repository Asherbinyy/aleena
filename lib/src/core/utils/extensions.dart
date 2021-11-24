import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



extension ScreenSpaces on double {
  SizedBox ESW() {
    return SizedBox(width: this.w,);
  }
  SizedBox ESH() {
    return SizedBox(height: this.h,);
  }
}