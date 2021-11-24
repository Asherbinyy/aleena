import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';

class EmptyWidget extends StatelessWidget {


  final String image;
  final String title;
  final String subtitle;

  EmptyWidget({this.image=' ', this.title=' ', this.subtitle=' '});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/$image',
          height: 167.h,
        ),
        29.0.ESH(),
        Container(
          width: 177.w,
          child: CustomText(
            text: title,
            color: KCMainBlack,
            fontW: FW.bold,
            fontSize: 20,
            textAlign: TextAlign.center,
          ),
        ),
        18.0.ESH(),
        Container(
          width: 177.w,
          child: CustomText(
            text: subtitle,
            color: KCMainGrey,
            fontW: FW.light,
            fontSize: 13,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
