import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/services/pin_code.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verfication_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:aleena/src/ui/widgets/titles/title_tow_in_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerficationScreen extends StatelessWidget {
  final String? phone;
  final bool register;
  final Function? onSuccess;
  final String? validationCode;
  VerficationScreen({required this.phone,this.register= true,this.validationCode,this.onSuccess});


  VerficationController verficationController = Get.put(VerficationController());
  @override
  Widget build(BuildContext context) {

    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        needAppBar: false,
        child: GetBuilder<VerficationController>(
          builder: (_) =>  KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) => SingleChildScrollView(
              child: Form(
                key: _.globalKey,
                child: Column(
                  children: [
                    Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 55.h
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'confirm_bin_code'.tr,
                              fontW: FW.regular,   // TODO convert font type to demi
                              fontSize: 16,
                              color: KCMainBlack,
                            ),
                            CustomText(
                              text: 'enter_bin_code_6'.tr,
                              fontW: FW.regular,
                              fontSize: 12,
                              color: KCMainBlack,
                            ),
                            CustomText(
                              text: phone,
                              fontW: FW.regular,
                              fontSize: 12,
                              color: KCMainBlack,
                            ),
                          ],
                        )
                    ),

                    PinCodeServices.pinCodeWidget(
                        context: context,
                        textEditingController: _.textEditingController!,
                        errorController: _.errorController!
                    ),
                    32.0.ESH(),
                    ButtonDefault(
                      title: "contain_".tr,
                      onTap: (){
                        submit(context);
                      },
                    ),
                    14.0.ESH(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     CustomText(
                    //       text: 'resend_after'.tr,
                    //       color: KCMainBlack,
                    //       fontSize: 15,
                    //       fontW: FW.medium,
                    //     ),
                    //     CustomText(
                    //       text: '(${'59:00'})',
                    //       color: KCSeconary,
                    //       fontSize: 15,
                    //       fontW: FW.medium,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
  void submit(BuildContext context) async {
    if (verficationController.textEditingController!.text.length == 6) {
      try {
        await onSuccess!(validationCode,verficationController.textEditingController!.text);
      } catch (e) {
        Get.back();
        Get.back();
        customSnackBar(
          title: 'Error_'.tr,
          subtitle:
          e.toString().contains("The SMS verification code used to create the phone auth credential is invalid")?
        "confirm_code_and_resend".tr:
          "confirm_code_and_resend".tr,
        );
        print(e);
      }
    }
  }

}

