import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/register_controller.dart';
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

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.put(RegisterController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        needAppBar: false,
        child: GetBuilder<RegisterController>(
          builder: (_) =>  KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) =>
                SingleChildScrollView(
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
                                  tile: 'sign_up'.tr,
                                )
                            ),
                            TextFieldDefault(
                              hint: 'Trade_name'.tr,
                              errorText: "must_enter_trade_name".tr,
                              controller: _.nameController,
                              upperTitle: 'Trade_name'.tr,
                              // keyboardType: TextInputType.phone,
                              // validation: phoneValidator,
                              onComplete: () {
                                node.nextFocus();
                              },
                            ),
                            16.0.ESH(),
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
                                node.nextFocus();
                                _.submit();
                              },
                            ),
                            16.0.ESH(),
                            TextFieldDefault(
                              hint: 'confirm_password'.tr,
                              errorText: "must_enter_password".tr,
                              controller: _.confirmPasswordController,
                              secureType: SecureType.Toggle,
                              upperTitle: 'confirm_password'.tr,
                              // validation: passwordValidator,
                              onComplete: () {
                                node.unfocus();
                                _.submit();
                              },
                            ),
                            23.0.ESH(),
                            ButtonDefault(
                              title: 'sign_up'.tr,
                              onTap: (){
                                _.submit();
                              },

                            ),
                            24.0.ESH(),
                            isKeyboardVisible?
                            0.0.ESH():
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:  EdgeInsets.only(
                                    bottom: 20.h
                                ),
                                child: Container(
                                    child: TitleTwoInLine(
                                      tile: 'have_account?'.tr,
                                      secondTile: 'sign_in'.tr,
                                      onTap: (){
                                        _.moveToLogin();
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


          ),
        ),
      )
    );
  }
}
