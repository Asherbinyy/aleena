import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_personal_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_shop_controller.dart';
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

class PersonalSettingsScreen extends StatefulWidget {
  final String? name;
  final String? phone;
  // final String? email;

  PersonalSettingsScreen({
    this.name,
    this.phone,
    // this.email,
  });

  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController? storeNameController;
  TextEditingController? phoneController;
  // TextEditingController? emailController;

  @override
  void initState() {
    // TODO: implement initState
    storeNameController = TextEditingController();
    phoneController = TextEditingController();
    // emailController = TextEditingController();
    storeNameController!.text = widget.name!;
    phoneController!.text = widget.phone!;
    // emailController!.text = widget.email!;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    storeNameController?.dispose();
    phoneController?.dispose();
    // emailController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UpdatePersonalInformation());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        appBar: AppBarBack(
          title: 'profile_Settings'.tr,
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
                        hint: 'enter_shop_name'.tr,
                        errorText: "must_enter_shop_name".tr,
                        controller: storeNameController,
                        upperTitle: 'shop_name'.tr,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      16.0.ESH(),
                      TextFieldDefault(
                        hint: 'enter_phone_number'.tr,
                        errorText: "must_enter_phone_number".tr,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        upperTitle: 'phone_number'.tr,
                        enable: false,
                        // validation: phoneValidator,
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                      // 16.0.ESH(),
                      // TextFieldDefault(
                      //   hint: 'enter_gmail'.tr,
                      //   errorText: "must_enter_gmail".tr,
                      //   controller: emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   upperTitle: 'gmail_'.tr,
                      //   // validation: phoneValidator,
                      //   onComplete: () {
                      //     node.nextFocus();
                      //   },
                      // ),
                      32.0.ESH(),
                      ButtonDefault(
                        title: 'save_'.tr,
                        onTap: () {
                          if (globalKey.currentState!.validate()) {
                            globalKey.currentState!.save();
                            _.updatePersonalInfo(name: storeNameController!.text,);
                          }
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
