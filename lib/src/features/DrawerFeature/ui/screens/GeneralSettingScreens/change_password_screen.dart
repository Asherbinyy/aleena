import 'package:aleena/src/features/DrawerFeature/bloc/controller/change_password_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_shop_controller.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ChangePasswordController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        appBar: AppBarBack(title: 'change_password'.tr,),
        child: SingleChildScrollView(
          child: GetBuilder<ChangePasswordController>(
            builder: (_) =>  Column(
              children: [
                Form(
                  key: _.globalKey,
                  child: Column(
                    children: [
                      30.0.ESH(),
                      TextFieldDefault(
                        hint: 'enter_old_password'.tr,
                        errorText: "must_enter_old_password".tr,
                        controller: _.oldPasswordController,
                        secureType: SecureType.Toggle,
                        upperTitle: 'enter_old_password'.tr,
                        // validation: passwordValidator,
                        onComplete: () {
                          node.unfocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'enter_new_password'.tr,
                        errorText: "must_enter_new_password".tr,
                        controller: _.newPasswordController,
                        secureType: SecureType.Toggle,
                        upperTitle: 'new_password'.tr,
                        // validation: passwordValidator,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'confirm_enter_new_password'.tr,
                        errorText: "must_confirm_enter_new_password".tr,
                        controller: _.confirmPasswordController,
                        secureType: SecureType.Toggle,
                        upperTitle: 'confirm_enter_new_password'.tr,
                        // validation: passwordValidator,
                        onComplete: () {
                          node.unfocus();
                          _.changePassword();
                        },
                      ),
                      32.0.ESH(),
                      ButtonDefault(
                        title: 'save_'.tr,
                        onTap: (){
                         _.changePassword();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
