import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowLangChoose extends StatefulWidget {
  final String flag;
  final String langTitle;
  final bool active;

  RowLangChoose(
      {required this.flag, required this.langTitle, this.active = false,});

  @override
  State<RowLangChoose> createState() => _RowLangChooseState();
}

class _RowLangChooseState extends State<RowLangChoose> {
  Object userInPutType = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: KCTFEnableBorder.withOpacity(0.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 26.h,
                width: 37.w,
                child: Image.asset(
                  widget.flag,
                  height: 26.h,
                  width: 37.w,
                ),
              ),
              16.0.ESW(),
              CustomText(
                text: widget.langTitle,
                fontW: FW.semibold,
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color:widget.active? KCBlueMenu:Colors.transparent,
                borderRadius: BorderRadius.circular(7777.r),
                border: Border.all(color:widget.active? Colors.transparent: KCMainGrey, width: 2.w,),
            ),
            height: 16.h,
            width: 16.h,
            child: widget.active?Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7777.r),
                ),
                height: 6.h,
                width: 6.h,
              ),
            ):0.0.ESH(),
          ),
        ],
      ),
    );
  }
}
