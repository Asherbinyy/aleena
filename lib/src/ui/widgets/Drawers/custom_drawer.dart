import 'package:flutter/material.dart';
import '/src/core/constants/color_constants.dart';
import '/src/core/utils/extensions.dart';
import '/src/ui/widgets/GeneralWidgets/custom_text.dart';
import '/src/ui/widgets/GeneralWidgets/image_network.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 16.w),
              width: double.infinity,
              color: KCBlueMenu,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: ImageNetwork(url: "",width: 40.w,height:40.w,),
                    radius: 20,
                  ),
                  16.0.ESW(),
                  CustomText(text: "xxx",color: Colors.white,fontW: FW.medium,fontSize: 13,),
                ],
              ),
            ),
            24.0.ESH(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 14.h),
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageIcon(const AssetImage("assets/icons/home.png"),color: Colors.white,size: 20.sp,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
