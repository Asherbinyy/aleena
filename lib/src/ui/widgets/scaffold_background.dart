import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Ui/Screen/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'logo/logo_default.dart';

class ScaffoldBackground extends StatelessWidget {
  final Widget? child;
  final Widget? appBar;
  final bool needAppBar;
  ScaffoldBackground({this.child, this.appBar , this.needAppBar=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: KCMain,
      child: Column(
        children: [
              Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            width: double.infinity,
            height: 110.h,
            child:          appBar??
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !needAppBar?0.0.ESH():
                InkWell(
                  onTap: () {
                    // Get.to(()=>const CustomDrawer());
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    child: ImageIcon(
                      const AssetImage("assets/icons/menu-line.png"),
                      color: Colors.white,
                      size: 22.w,
                    ),
                  ),
                ),
                    Center(
                      child: LogoDefault(
                        height: 48,
                        width: 64,
                      ),
                    ),
                !needAppBar?0.0.ESH():
                InkWell(
                  onTap: () {
                    Get.to(()=>NotificatinsScreen());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    child: ImageIcon(
                      const AssetImage("assets/icons/notification.png"),
                      color: Colors.white,
                      size: 22.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                  color: Colors.white),
              child: child ?? Center(),
            ),
          ),
        ],
      ),
    );
  }
}
