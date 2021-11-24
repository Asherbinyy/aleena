import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar({String title='', String subtitle = ''}){
  Get.snackbar(
    '','',
    backgroundColor: KCMainBlack,
    snackPosition: SnackPosition.TOP,
    titleText: CustomText(
      text: title,
      color: Colors.white,
      fontW: FW.bold,
      fontSize: 15,
    ),
    messageText: CustomText(
      text: subtitle,
      color: Colors.white,
      fontW: FW.medium,
      fontSize: 12,
    ),
  );
}