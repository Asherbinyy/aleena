import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DrawerRowForm extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;


  DrawerRowForm({required this.icon,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: KCActiveButton,
      highlightColor: KCActiveButton,
      hoverColor: KCActiveButton,
      splashColor: KCActiveButton,
      autofocus:true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
        // height: 48.h,
        // color: Colors.red,
        width: double.infinity,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            // height: 22.h,
            // color: Colors.black,
            child: Row(
              children: [
                SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: ImageIcon(
                    AssetImage("assets/icons/$icon.png"),
                    size: 20.w,
                    color: KCDarkGrey,
                  ),
                ),
                16.h.ESW(),
                CustomText(
                  text: title,
                  fontSize: 16,
                  fontW: FW.medium,
                  color: KCDarkGrey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
