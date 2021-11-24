
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';

class TitleCardOrder extends StatelessWidget {
  final String? title;
  final String? subtitle;


  TitleCardOrder({this.title=' ', this.subtitle=' '});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: title,
          fontW: FW.light,
          color: KCDarkGrey,
          fontSize: 11,
        ),
        CustomText(
          text: subtitle,
          fontW: FW.medium,
          color: KCDarkGrey,
          fontSize: 12,
        ),
      ],
    );
  }
}
