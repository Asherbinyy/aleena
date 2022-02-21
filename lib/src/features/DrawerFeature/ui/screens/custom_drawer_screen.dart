import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/log_out_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/privacy_and_terms_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/LastOrdersScreen/last_orders_screen.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/return_orders_screen.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/drawer_row_form.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CallUsScreen/call_us_screen.dart';
import 'GeneralSettingScreens/general_settings_screen.dart';
import 'PrivacyPolicyScreen/privacy_policy_screen.dart';
import 'TermsScreen/terms_screen.dart';
import 'WhoAreWeScreen/who_are_we_screen.dart';

class CustomDrawerScreen extends StatelessWidget {
  GetStorage box = GetStorage();

  launchURL() async {
    const url = "https://crazyideaco.com/";
    _launch(url);

  }

  _launch(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyAndTermsController());
    LogOutController _logOutController = Get.put(LogOutController());
    return Drawer(
      child: SafeArea(
        child: GetBuilder<PrivacyAndTermsController>(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    width: double.infinity,
                    color: KCBlueMenu,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(777.r),
                          child: CircleAvatar(
                            child: ImageNetwork(
                              url: box.read("avatarShop") ?? "",
                              width: 40.w,
                              height: 40.w,
                            ),
                            radius: 20,
                          ),
                        ),
                        16.0.ESW(),
                        CustomText(
                          text: box.read("name") ?? "",
                          color: Colors.white,
                          fontW: FW.medium,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ),
                  16.h.ESH(),
                  DrawerRowForm(
                      title: "Home_".tr,
                      icon: "home",
                      onTap: () {
                        Get.back();
                        Get.offAll(() => HomeScreen());
                      }),
                  16.h.ESH(),
                  DrawerRowForm(
                      title: "Last_orders".tr,
                      icon: "order",
                      onTap: () {
                        Get.back();
                        Get.to(() => LastOrdersScreen());
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                      title: "return_orders".tr,
                      icon: "order",
                      onTap: () {
                        Get.back();
                        Get.to(() => ReturnOrdersScreen());
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                      title: "General_Settings".tr,
                      icon: "setting",
                      onTap: () {
                        Get.back();
                        Get.to(() => const GeneralSettingScreens());
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                      title: "call_us".tr,
                      icon: "call",
                      onTap: () {
                        Get.back();
                        Get.to(() => CallUsScreen());
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                      title: "who_are_we".tr,
                      icon: "about",
                      onTap: () {
                        Get.back();
                        Get.to(() => WhoAreWeScreen());
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                      title: "Privacy_policy".tr,
                      icon: "privacy",
                      onTap: () {
                        Get.back();
                        Get.to(() => PrivacyPolicyScreen(
                              privacyList: _.privacyList,
                            ));
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                      title: "terms_and_condition".tr,
                      icon: "privacy",
                      onTap: () {
                        Get.back();
                        Get.to(() => TermsScreen(
                              termsList: _.termsList,
                            ));
                      }),
                  12.h.ESH(),
                  DrawerRowForm(
                    title: "sign_out".tr,
                    icon: "logOut",
                    onTap: () {
                      _logOutController.logOut();
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  launchURL();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          "Made With ❤ By Crazy Idea",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: KCMainGrey, fontSize: 14.w),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomText(
                          text: "Think Out Of The Box",
                          color: KCMainGrey,
                          fontW: FW.semibold,
                          fontSize: 13.sp,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
