import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_address_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_personal_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_shop_controller.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UpdateShopAddressScreen extends StatefulWidget {
  final String? address;
  UpdateShopAddressScreen({
    this.address,
  });

  @override
  State<UpdateShopAddressScreen> createState() => _UpdateShopAddressScreenState();
}

class _UpdateShopAddressScreenState extends State<UpdateShopAddressScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController? addressController;

  @override
  void initState() {
    // TODO: implement initState
    addressController = TextEditingController();
    addressController!.text = widget.address!;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    addressController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UpdateAddressController _updateAddressController =Get.put(UpdateAddressController());
    Get.put(UpdatePersonalInformation());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        appBar: AppBarBack(
          title: 'shop_address'.tr,
        ),
        child: SingleChildScrollView(
          child: GetBuilder<UpdatePersonalInformation>(
            builder: (_) => Column(
              children: [
                Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      30.0.ESH(),
                      TextFieldDefault(
                        hint: 'enter_address'.tr,
                        errorText: "must_enter_address".tr,
                        controller: addressController,
                        upperTitle: 'address_'.tr,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.unfocus();
                        },
                      ),
                      32.0.ESH(),
                      ButtonDefault(
                        title: 'change_address'.tr,
                        onTap: () {
                          print("sssssssssss555555555");
                            Get.offAll(()=>MapScreen(
                              onSave:  (lat, lon, address,areaId){
                                _updateAddressController.updateAddress(lat: lat,lon: lon,address: address);
                              },
                            ));
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
