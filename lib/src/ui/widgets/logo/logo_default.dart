import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LogoDefault extends StatelessWidget {
  final int? height;
  final int? width;

  LogoDefault({this.height = 67, this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/logo.png',
      height: height!.h,
      width: width!.w,
    );
  }
}
