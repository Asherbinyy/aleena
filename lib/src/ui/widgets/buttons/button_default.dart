import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';
import 'base_button.dart';


enum ButtonStyle{
  withBorder,
  withOutBorder
}


class ButtonDefault extends StatelessWidget {
  final String title;
  final String iconImage;
  final Color buttonColor;
  final Color disActiveButtonColor;
  final Color titleColor;
  final Color iconColor;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double radius;
  final double textSize;
  final double iconHeight;
  final Color? borderColor;
  final Color disActiveBorderColor;
  final bool? active;
  final Widget? child;

  ButtonDefault({
    this.child,
    this.borderColor,this.disActiveButtonColor=KCDisActiveButton,this.disActiveBorderColor=KCDisActiveButton,this.textSize=16,this.iconHeight=12,this.radius=KNRadius,this.title='', this.iconImage='', this.buttonColor=KCActiveButton, this.titleColor=KCButtonTitle,
    this.iconColor=KCButtonTitle, this.onTap,this.height=56,this.width=343,this.active=true
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      height: height,
      width: width,
      radius: radius,
      borderColor: active! ? borderColor :disActiveBorderColor,
      buttonColor: active! ? buttonColor:disActiveButtonColor,
      onTap: onTap,
      child: child??drawChild(),
    );
  }

  Widget drawChild(){
    if(title.isNotEmpty&&iconImage.isEmpty){
      // TODO return text only
      return Center(
        child: CustomText(
          text: title,
          color: titleColor,
          fontSize: textSize,
          fontW: FW.semibold,
        ),
      );
    }else if(title.isEmpty&&iconImage.isNotEmpty){
      // TODO return icon only
      return Center(
        child: Image.asset(
          'assets/icons/$iconImage',
          color: iconColor,
          height: iconHeight,
        )
        );
    }else if(title.isNotEmpty&&iconImage.isNotEmpty){
      // TODO return icon and text
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              color: titleColor,
              fontSize: textSize,
              fontW: FW.semibold,
            ),
            7.0.ESW(),
            Image.asset(
              'assets/icons/$iconImage',
              color: iconColor,
              height: iconHeight,
            )
          ],
        ),
      );
    }else{
      // TODO return text only
      return Center(
        child: CustomText(
          text: title,
          color: titleColor,
          fontSize: textSize,
          fontW: FW.semibold,
        ),
      );
    }
  }
}
