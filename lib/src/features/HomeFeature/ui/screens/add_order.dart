import 'package:aleena/src/features/HomeFeature/bloc/controller/add_order_controller.dart';
import 'package:aleena/src/features/HomeFeature/bloc/controller/home_controller.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/cards/card_payment.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AddOrderScreen extends StatelessWidget {
  final double? lat;
  final double? lon;
  final String? address;
  final String fee;
  final bool inside;


  AddOrderScreen({this.lat, this.lon, this.address, this.fee = '0',this.inside=true});

  @override
  Widget build(BuildContext context) {
    Get.put(AddOrderController(lat: this.lat,lon: this.lon,address: this.address,deliveryFee: this.fee,inside:inside ));
    Get.put(HomeController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        appBar: AppBarBack(title: 'اضافة طلب',),
        child: GetBuilder<AddOrderController>(
          builder: (_) =>  Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _.globalKey,
                  child:Column(
                    children: [
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'enter_order_num'.tr,
                        errorText: "must_enter_order_num".tr,
                        controller: _.orderNumberController,
                        keyboardType: TextInputType.number,
                        upperTitle: 'order_num'.tr,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'enter_clint_name'.tr,
                        errorText: "must_enter_clint_name".tr,
                        controller: _.clientNameController,
                        upperTitle: 'clint_name'.tr,
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
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>MapScreen(
                            // targetPosition: position,
                            onSave: (double lat , double lon , String address,areaId){
                              _.changeAddress(address);
                              _.changeLat(lat);
                              _.changeLon(lon);
                              Get.back();
                            },));
                        },
                        child: TextFieldDefault(
                          enable: false,
                          hint: 'enter_address'.tr,
                          errorText: "must_enter_address".tr,
                          controller: _.addressController,
                          keyboardType: TextInputType.number,
                          upperTitle: 'address_'.tr,
                          // validation: phoneValidator,
                          onComplete: () {
                            node.nextFocus();
                          },
                        ),
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'mark_place'.tr,
                        controller: _.markController,
                        upperTitle: 'mark_place'.tr,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'Enter_the_required_price'.tr,
                        errorText: "must_Enter_the_required_price".tr,
                        controller: _.priceController,
                        keyboardType: TextInputType.number,
                        upperTitle: 'the_required_price'.tr,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.unfocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'Enter_the_delivery_fee'.tr,
                        enable: false,
                        controller: _.deliveryFeeController,
                        keyboardType: TextInputType.number,
                        upperTitle: 'delivery_fee'.tr,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.unfocus();
                        },
                      ),
                      16.0.ESH(),
                      Row(
                        children: [
                          Checkbox(value: _.returnable, onChanged: (value){_.returnable=value!;}),
                          CustomText(
                            text: 'returnable'.tr,
                            fontSize: 16,
                            fontW: FW.medium,
                            color: Color(0xff999999),
                          ),
                        ],
                      ),
                      16.0.ESH(),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            CustomText(
                              text: 'payment_method'.tr,
                              fontSize: 16,
                              fontW: FW.medium,
                              color: Color(0xff999999),
                            ),
                          ],
                        ),
                      ),

                      16.0.ESH(),
                      CardPayment(
                        onTap: (){
                          _.paymentMethod='cash';
                        },
                        title: 'payment_cash_when_delivery'.tr,icon: 'cash.png',active:  _.paymentMethod=='cash',),
                      16.0.ESH(),
                      CardPayment(
                        onTap: (){
                          _.paymentMethod='visa';
                        },
                        title: 'payment_cash_by_credit_card'.tr,icon: 'visa.png',active: _.paymentMethod=='visa',),
                        100.0.ESH(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(
                    bottom: 16.h
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonDefault(
                    title: "save_".tr,
                    onTap: (){
                      _.submit();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
