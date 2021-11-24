import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomRadio extends StatelessWidget {
  final bool active;


  CustomRadio({this.active=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width:  15.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.transparent,
        border: Border.all(width: active ? 4 : 2 ,color: active ? Color(0xff4625AC):Color(0xff898989)),
      ),
      
    );
  }
}
