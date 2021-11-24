import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class OrderTypeChoice extends StatelessWidget {
  final int status;
  final Function(int)? onTap;
  OrderTypeChoice({this.status=0,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xffEEEEF0),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 4.h
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  onTap!(0);
                },
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: status==0?Colors.white:Colors.transparent,
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'waiting_'.tr,
                      color:  status==0?KCMainBlack:Color(0xff858585),
                      fontSize: 14,
                      fontW: FW.medium,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  onTap!(1);
                },
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: status==1?Colors.white:Colors.transparent,
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'take_away'.tr,
                      color:  status==1?KCMainBlack:Color(0xff858585),
                      fontSize: 14,
                      fontW: FW.medium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
