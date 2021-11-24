import 'package:aleena/src/features/AuthFeature/bloc/controller/check_phone_controller.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:aleena/src/ui/widgets/titles/title_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CheckPhoneController checkPhoneController = Get.put(CheckPhoneController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        needAppBar: false,
        child: GetBuilder<CheckPhoneController>(
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
                          child:
                          TitleSubtitle(
                            tile: 'please_enter_phone_title'.tr,
                            subtitle: 'please_enter_phone_sub_title'.tr,
                          )
                      ),
                      TextFieldDefault(
                        hint: 'enter_phone_number'.tr,
                        errorText: "must_enter_phone_number".tr,
                        controller: _.phoneController,
                        keyboardType: TextInputType.phone,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      50.0.ESH(),
                      ButtonDefault(
                        title: 'contain_'.tr,
                        active: _.phoneNotEmpty,
                        onTap: (){
                          _.submit();
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
