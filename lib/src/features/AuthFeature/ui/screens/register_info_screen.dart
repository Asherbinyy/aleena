import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/register_info_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/set_avatar_widget.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/update_avatar_widget.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterInfoController registerInfoController = Get.put(RegisterInfoController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        needAppBar: false,
        child: SingleChildScrollView(
          child: GetBuilder<RegisterInfoController>(
            builder: (_) =>  Form(
              key: _.globalKey,
              child: Column(
                children: [
                  34.0.ESH(),
                  CustomText(
                    text: 'shop_info'.tr,
                    color: KCMainBlack,
                    fontSize: 18,
                    fontW: FW.bold,
                  ),
                  34.0.ESH(),
                  SetAvatarWidget(),
                  34.0.ESH(),
                  TextFieldDefault(
                    hint: 'shop_admin'.tr,
                    errorText: "must_enter_shop_admin".tr,
                    controller: _.nameController,
                    upperTitle: 'admin_name'.tr,
                    // validation: phoneValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  16.0.ESH(),
                  TextFieldDefault(
                    hint: 'num_8'.tr,
                    errorText: "must_enter_commercial_register".tr,
                    controller: _.taxisController,
                    upperTitle: 'commercial_register_num'.tr,
                    // validation: phoneValidator,
                    isSuffixIcon: true,
                    suffixIconData: Icons.camera_alt_outlined,
                    onSuffixTap: () async {
                      await _.getCommercialRegisterImage();
                    },
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  16.0.ESH(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      height: 149.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kCBackGroundColor,
                          borderRadius: BorderRadius.circular(5.r),
                          border:
                          Border.all(width: 1, color: KCTFEnableBorder)),
                      child:  _.commercialRegisterImage == null
                          ? Center(
                        child: SizedBox(
                          height: 44.h,
                          width: 52.w,
                          child: Image.asset(
                            'assets/icons/uploadePhoto.png',
                            height: 44.h,
                            width: 52.w,
                          ),
                        ),
                      )
                          : Image.file(
                        _.commercialRegisterImage!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )

                    ),
                  ),
                  16.0.ESH(),
                  TextFieldDefault(
                    hint: 'num_8'.tr,
                    errorText: "must_enter_tax_record_num".tr,
                    controller: _.darayebController,
                    keyboardType: TextInputType.number,
                    upperTitle: 'tax_record_num'.tr,
                    // validation: phoneValidator,
                    isSuffixIcon: true,
                    suffixIconData: Icons.camera_alt_outlined,
                    onSuffixTap: () {
                      print("_.taxisNumberImage ${_.taxisNumberImage}");
                      _.getTaxisNumberImageImage();
                    },
                    onComplete: () {
                      node.unfocus();
                      _.submit();
                    },
                  ),
                  16.0.ESH(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      height: 149.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kCBackGroundColor,
                          borderRadius: BorderRadius.circular(5.r),
                          border:
                          Border.all(width: 1, color: KCTFEnableBorder)),
                      child:_.taxisNumberImage == null
                          ? Center(
                        child: SizedBox(
                            height: 44.h,
                            width: 52.w,
                            child: Image.asset(
                              'assets/icons/uploadePhoto.png',
                              height: 44.h,
                              width: 52.w,
                            )),
                      )
                          : Image.file(
                        _.taxisNumberImage!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )

                    ),
                  ),
                  43.0.ESH(),
                  ButtonDefault(title: "contain_".tr,onTap: (){_.submit();},),
                  43.0.ESH(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
