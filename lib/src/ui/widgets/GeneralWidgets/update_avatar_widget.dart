import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/register_info_controller.dart';
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

class UpdateAvatarWidget extends StatefulWidget {
  final String avatar;

  const UpdateAvatarWidget({
    this.avatar = '',
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateAvatarWidget> createState() => _UpdateAvatarWidgetState();
}

class _UpdateAvatarWidgetState extends State<UpdateAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    UpdateShopAvatar _updateShopAvatar = Get.put(UpdateShopAvatar());

    return GetBuilder<UpdateShopAvatar>(
      builder: (_) => Container(
        width: 122.h,
        height: 122.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: kCBackGroundColor,
        ),
        child: Stack(
          children: [
            widget.avatar.isEmpty
                ? _.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(777.r),
                        child: Image.file(
                          _.image!,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 188.h,
                        ),
                      )
                    : Center(
                        child: Image.asset(
                          'assets/icons/photoicon.png',
                          height: 51.h,
                        ),
                      )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(777.r),
                    child: ImageNetwork(
                        url: widget.avatar, width: 122.h, height: 122.h)),
            GestureDetector(
              onTap: () async {
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
                      border: Border.all(color: Colors.white, width: 2)),
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
