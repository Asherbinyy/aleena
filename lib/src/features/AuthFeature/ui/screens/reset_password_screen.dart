import 'package:aleena/src/features/AuthFeature/bloc/controller/reset_password_controller.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:aleena/src/ui/widgets/titles/title_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String phone;

  ResetPasswordScreen({required this.phone});

  @override
  Widget build(BuildContext context) {
    print("phone in ResetPasswordScreen is $phone");
    ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        needAppBar: false,
        child: GetBuilder<ResetPasswordController>(
          builder: (_) =>  SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _.globalKey,
                  child: Column(
                    children: [
                      Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 32.h
                          ),
                          child: TitleSubtitle(
                            tile: 'enter_new_password'.tr,
                            subtitle: '',
                          )
                      ),
                      TextFieldDefault(
                        hint: 'new_password'.tr,
                        errorText: "must_enter_new_password".tr,
                        controller: _.passwordController,
                        secureType: SecureType.Toggle,
                        upperTitle: 'new_password'.tr,
                        // validation: passwordValidator,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'confirm_password'.tr,
                        errorText: "must_enter_new_password".tr,
                        controller: _.confirmPasswordController,
                        secureType: SecureType.Toggle,
                        upperTitle: 'confirm_password'.tr,
                        // validation: passwordValidator,
                        onComplete: () {
                          node.unfocus();
                          _.submit(phone: '');
                        },
                      ),
                      32.0.ESH(),
                      ButtonDefault(
                        title: "save_".tr,
                        onTap: (){
                          _.submit(phone: phone);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
