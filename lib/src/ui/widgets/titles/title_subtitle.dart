import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import '/src/core/utils/extensions.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class TitleSubtitle extends StatelessWidget {

  // texts

  final String tile;
  final String subtitle;

  // sizes

  final double tileSize;
  final double subTitleSize;


  // colors

  final Color tileColor;
  final Color subTitleColor;




  TitleSubtitle({
    this.tile='',
    this.subtitle='',
    this.tileSize=18.0,
    this.subTitleSize=12.0,
    this.tileColor= KCMainBlack,
    this.subTitleColor = KCSubTitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: tile,
          color: tileColor,
          fontW: FW.bold,
          fontSize: tileSize,
          textAlign: TextAlign.center,
        ),
        8.0.ESH(),
        Container(
          width: 330.w,
          child: CustomText(
            text: subtitle,
            color: subTitleColor,
            fontW: FW.light,
            fontSize: subTitleSize,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
