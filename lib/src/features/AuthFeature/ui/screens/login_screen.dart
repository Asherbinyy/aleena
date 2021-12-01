import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/fetch_and_set_city_and_area_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/login_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:aleena/src/ui/widgets/titles/title_subtitle.dart';
import 'package:aleena/src/ui/widgets/titles/title_tow_in_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    var node = FocusScope.of(context);
    return Scaffold(
        body: ScaffoldBackground(
      needAppBar: false,
      child: GetBuilder<LoginController>(
        builder: (_) => KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _.globalKey,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              child: TitleSubtitle(
                                tile: 'sign_in'.tr,
                              )),
                          TextFieldDefault(
                            hint: 'enter_phone_number'.tr,
                            errorText: "must_enter_phone_number".tr,
                            controller: _.phoneController,
                            keyboardType: TextInputType.phone,
                            upperTitle: 'phone_number'.tr,
                            // validation: phoneValidator,
                            onComplete: () {
                              node.nextFocus();
                            },
                          ),
                          16.0.ESH(),
                          TextFieldDefault(
                            hint: 'enter_password'.tr,
                            errorText: "must_enter_password".tr,
                            controller: _.passwordController,
                            secureType: SecureType.Toggle,
                            upperTitle: 'password_'.tr,
                            // validation: passwordValidator,
                            onComplete: () {
                              node.unfocus();
                              _.submit();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 16.w,
                                    top: 16.h,
                                    bottom: 24.h),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _.onForgetPassword();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 4.h),
                                      child: CustomText(
                                        text: 'forget_password?'.tr,
                                        fontW: FW.semibold,
                                        fontSize: 15,
                                        color: KCSeconary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ButtonDefault(
                            title: 'sign_in'.tr,
                            onTap: () {
                              _.submit();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isKeyboardVisible
                  ? 0.0.ESH()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Container(
                            child: TitleTwoInLine(
                          tile: 'do_not_have_account?'.tr,
                          secondTile: 'sign_up'.tr,
                          onTap: () {
                            _.moveToRegister();
                          },
                        )),
                      ),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
