import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/SplachFeature/bloc/controlelr/splach_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  Get.put(SplashController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: KCMain,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            10.0.ESH(),
            Image.asset(
              'assets/icons/logo.png',
              width: double.infinity,
              height: 104.h,
            ),
            Image.asset(
              'assets/icons/textlogo.png',
              width: double.infinity,
              height: 79.h,
            ),
          ],
        )
      ),
    );
  }
}
