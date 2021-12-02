import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_info_screen.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/shop_info_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/general_setting_row_form.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/general_setting_row_notification_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/dialogs/sheet_lang.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'change_password_screen.dart';
import 'personal_settings.dart';
import 'UpdateShopAddressScreen/update_shop_address_screen.dart';
import 'update_shop_info_screen.dart';

class GeneralSettingScreens extends StatelessWidget {
  const GeneralSettingScreens({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ShopInfoController());
    return SafeArea(
      child: Scaffold(
        body: ScaffoldBackground(
          appBar: AppBarBack(
            title: 'General_Settings'.tr,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GetBuilder<ShopInfoController>(
              builder: (_) => Column(
                children: [
                  24.0.ESH(),
                  GeneralSettingRowForm(
                      onTap: () {
                        Get.to(() => PersonalSettingsScreen(
                              phone: _.phone,
                              // email: _.email,
                              name: _.name,
                            ));
                      },
                      title: "profile_Settings".tr),
                  const Divider(color: kCMainDivider, height: 1),
                  GeneralSettingRowForm(
                      onTap: () {
                        Get.to(() => ChangePasswordScreen());
                      },
                      title: "change_password".tr),
                  const Divider(color: kCMainDivider, height: 1),
                  GeneralSettingRowForm(
                      onTap: () {
                        Get.to(() => UpdateShopInfoScreen(
                          commericalRegisterImage: _.commericalRegisterImage,
                              taxRegisterNumberImage: _.taxRegisterImage,
                              avatar: _.avatar,
                              adminName: _.adminName,
                              commericalRegisterNumber:
                                  _.commericalRegisterNumber,
                              taxRegisterNumber: _.taxRegisterNumber,
                            ));
                      },
                      title: "shop_info".tr),
                  const Divider(color: kCMainDivider, height: 1),
                  GeneralSettingRowForm(
                      onTap: () {
                        Get.to(()=> UpdateShopAddressScreen(address: _.address,));
                      },
                      title: "shop_address".tr),
                  const Divider(color: kCMainDivider, height: 1),
                  GeneralSettingRowForm(
                      onTap: () {
                        Get.dialog(SheetLang());
                      },
                      title: "Lang_".tr),
                  const Divider(color: kCMainDivider, height: 1),
                  GeneralSettingRowNotificationForm(
                    // notifyStatus:_.notyStatus==1?true:false ,
                  ),
                  const Divider(color: kCMainDivider, height: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
