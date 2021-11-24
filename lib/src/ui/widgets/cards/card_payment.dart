
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CardPayment extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool active;
  final VoidCallback? onTap;

  CardPayment({this.title, this.icon, this.active=false,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??(){},
      child: Container(
        width: 343.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: KCCardBack,
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 17.w,
            vertical: 17.h
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/${icon}',
                height: 26.h,
              ),
              CustomText(
                text: title,
                color: KCMainBlack,
                fontW: FW.medium,
                fontSize: 15,
              ),
              const Spacer(),
              CustomRadio(active: active,),
            ],
          ),
        ),
      ),
    );
  }
}
