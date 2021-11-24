import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarBack extends StatelessWidget {
  final String? title;
  AppBarBack({this.title=' '});
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      // height: 80,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                width: 30.w,
                color: Colors.transparent,
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    vertical: 10.h
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                        size: 19.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomText(
              text: title,
              color: Colors.white,
              fontSize: 16,
              fontW: FW.medium,
            ),
            10.0.ESW(),
          ],
        ),
      ),
    );
  }
}
