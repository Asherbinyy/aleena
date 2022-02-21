import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';

class StaticsContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color color1;
  final Color color2;


  StaticsContainer({this.title=' ', this.subtitle=' ', this.icon=' ',required this.color1,required this.color2});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(KNCardRadius),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors:  [
            color1,
            color2
          ]
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 34.w,
            width:  34.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: Colors.white.withOpacity(.3),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/${icon}',
                height: 18.w,
                width:  18.w,
              ),
            ),
          ),
          3.0.ESH(),
          CustomText(
            // text: 'order_details'.tr,
            text:title,
            fontSize: 10,
            color: Colors.white,
            fontW: FW.light,
          ),
          3.0.ESH(),
          CustomText(
            // text: 'order_details'.tr,
            text:subtitle,
            fontSize: 18,
            color: Colors.white,
            fontW: FW.bold,
          ),
        ],
      ),
    );
  }
}
