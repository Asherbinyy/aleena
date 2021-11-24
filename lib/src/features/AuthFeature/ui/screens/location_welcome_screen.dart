import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/empty_widget.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class LocationWelcomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              10.0.ESH(),
              EmptyWidget(
                title: 'shop_address'.tr,
                subtitle: 'enter_shop_address'.tr,
                image: 'lacationearyh.png',
              ),
             Container(
               height: 112.h,
               child: Column(
                 children: [
                   ButtonDefault(title: 'select_location_automatic'.tr,onTap: (){},),
                   ButtonDefault(title: 'enter_location_manual'.tr,onTap: (){},buttonColor: Colors.transparent,titleColor: KCSeconary,),
                 ],
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
