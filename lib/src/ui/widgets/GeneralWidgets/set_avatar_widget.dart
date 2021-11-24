import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/register_info_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/set_avatar_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_shop_avatar_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/image_network.dart';
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


class SetAvatarWidget extends StatefulWidget {
  const SetAvatarWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<SetAvatarWidget> createState() => _SetAvatarWidgetState();
}
class _SetAvatarWidgetState extends State<SetAvatarWidget> {

  @override
  Widget build(BuildContext context) {
    SetAvatarController _setAvatarController = Get.put(SetAvatarController());
    return GetBuilder<SetAvatarController>(
      builder:(_) =>  Container(
        width: 122.h,
        height: 122.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: kCBackGroundColor,
        ),
        child: Stack(
          children: [
            _.image!=null?  ClipRRect(
              borderRadius: BorderRadius.circular(777.r),
              child: Image.file(
                _.image!,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 188.h,
              ),
            ):
            Center(
              child: Image.asset(
                'assets/icons/photoicon.png',
                height: 51.h,
              ),
            ),
            GestureDetector(
              onTap: ()async{
                await _.getImage();
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 30.h,
                  height: 30.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: KCSeconary,
                      border: Border.all(color: Colors.white,width: 2)
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 13.h,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
