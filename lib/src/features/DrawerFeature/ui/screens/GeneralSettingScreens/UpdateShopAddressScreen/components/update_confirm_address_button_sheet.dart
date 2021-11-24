import 'package:aleena/src/bloc/controllers/set_rate_controller.dart';
import 'package:aleena/src/bloc/models/lang_model.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/fetch_and_set_city_and_area_controller.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/ConfirmAddressButtonSheet/Component/area_sheet.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/ConfirmAddressButtonSheet/Component/city_sheet.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/fetch_and_update_city_and_area_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/lang_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/row_lang_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/row_top_bottom_sheet.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/src/core/utils/extensions.dart';
import 'update_area_sheet.dart';
import 'update_city_sheet.dart';


class UpdateShopAddressButtonSheet extends StatefulWidget {
  @override
  State<UpdateShopAddressButtonSheet> createState() => _UpdateShopAddressButtonSheetState();
}
class _UpdateShopAddressButtonSheetState extends State<UpdateShopAddressButtonSheet> {
  @override
  Widget build(BuildContext context) {
    // FetchAndSetCityAndAreaController _cityController = Get.put(FetchAndSetCityAndAreaController());
    FetchAndUpdateCityAndAreaController _etchAndUpdateCityAndAreaController = Get.put(FetchAndUpdateCityAndAreaController());

    var node = FocusScope.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(19.r),
          topRight: Radius.circular(19.r),
        ),
        child: Container(
          width: double.infinity,
          height: 440.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19.r),
                topRight: Radius.circular(19.r),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GetBuilder<FetchAndUpdateCityAndAreaController>(
                builder:(_) => Form(
                  key: _.globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      24.0.ESH(),
                      RowTopBottomSheet(title: "shop_address".tr),
                      32.0.ESH(),
                       InkWell(
                          onTap: (){
                            print("ahooooooooooooo");
                            Get.bottomSheet(UpdateCityButtonSheet(cityList: _.cityList!,));
                          },
                          child: TextFieldDefault(
                            hint: 'city_'.tr,
                            errorText: "must_set_city".tr,
                            controller: _.cityController,
                            upperTitle: 'city_'.tr,
                            // validation: phoneValidator,
                            suffixIconData: Icons.keyboard_arrow_down_outlined,
                            enable: false,
                            onComplete: () {
                              node.nextFocus();
                            },
                          ),
                      ),
                      22.0.ESH(),
                      InkWell(
                        onTap: (){
                         if(_.areaList!.isEmpty){
                           print("area List is Empty");
                         }else{
                           print("area List is Not Empty");
                           Get.bottomSheet(UpdateAreaButtonSheet(areaList: _.areaList!,));
                         }
                        },
                        child: TextFieldDefault(
                          hint: 'area_'.tr,
                          errorText: "must_set_area".tr,
                          controller: _.areaController,
                          upperTitle: 'area_'.tr,
                          enable: false,
                          // validation: phoneValidator,
                          suffixIconData: Icons.keyboard_arrow_down_outlined,
                          onComplete: () {
                            node.nextFocus();
                          },
                        ),
                      ),
                      22.0.ESH(),
                      // TextFieldDefault(
                      //   hint: 'address_'.tr,
                      //   errorText: "must_enter_address".tr,
                      //   controller: _.addressController,
                      //   upperTitle: 'address_'.tr,
                      //   // validation: phoneValidator,
                      //   onComplete: () {
                      //     node.nextFocus();
                      //   },
                      // ),
                      // 22.0.ESH(),
                      ButtonDefault(
                        title: 'confirm_address'.tr,
                        onTap: () {
                          _.submit();
                        },
                      ),
                      22.0.ESH(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
