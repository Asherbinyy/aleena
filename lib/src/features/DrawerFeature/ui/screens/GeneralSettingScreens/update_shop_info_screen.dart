import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/register_info_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/update_shop_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/update_avatar_widget.dart';
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

class UpdateShopInfoScreen extends StatefulWidget {
  final String avatar;
  final String adminName;
  final String commericalRegisterNumber;
  final String commericalRegisterImage;
  final String taxRegisterNumber;
  final String taxRegisterNumberImage;

  UpdateShopInfoScreen({
    required this.avatar,
    required this.adminName,
    required this.commericalRegisterNumber,
    required this.taxRegisterNumber,
    required this.commericalRegisterImage,
    required this.taxRegisterNumberImage,
  });

  @override
  State<UpdateShopInfoScreen> createState() => _UpdateShopInfoScreenState();
}

class _UpdateShopInfoScreenState extends State<UpdateShopInfoScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController? nameController;
  TextEditingController? taxisController;
  TextEditingController? darayebController;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    taxisController = TextEditingController();
    darayebController = TextEditingController();
    nameController!.text = widget.adminName;
    taxisController!.text = widget.taxRegisterNumber;
    darayebController!.text = widget.commericalRegisterNumber;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController?.dispose();
    taxisController?.dispose();
    darayebController?.dispose();
    super.dispose();
  }

  File _image = File('xxx');
  final picker = ImagePicker();

  Future getImage() async {
    await picker.getImage(source: ImageSource.gallery).then((value) async {
      setState(() {
        if (value != null) {
          _image = File(value.path);
        } else {
          print('No image selected.');
        }
      });
      print("_image $_image");
      // await Provider.of<UserInfoProvider>(context, listen: false).updateImage(image: File(value.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    print("widget.taxRegisterNumberImage ${widget.taxRegisterNumberImage}");
    UpdateShopInfoController _updatePersonalInfoController =
        Get.put(UpdateShopInfoController());
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
        appBar: AppBarBack(
          title: 'shop_info'.tr,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: GetBuilder<UpdateShopInfoController>(
              builder: (_) => Column(
                children: [
                  34.0.ESH(),
                  CustomText(
                    text: 'shop_info'.tr,
                    color: KCMainBlack,
                    fontSize: 18,
                    fontW: FW.bold,
                  ),
                  34.0.ESH(),
                  UpdateAvatarWidget(
                    avatar: widget.avatar,
                  ),
                  34.0.ESH(),
                  TextFieldDefault(
                    hint: 'shop_admin'.tr,
                    errorText: "must_enter_shop_admin".tr,
                    controller: nameController,
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
                    controller: taxisController,
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
                      child: widget.commericalRegisterImage.isEmpty
                          ? _.commercialRegisterImage == null
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
                                  fit: BoxFit.fill,
                                )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5.r),
                              child: ImageNetwork(
                                url: widget.commericalRegisterImage,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                  ),
                  16.0.ESH(),
                  TextFieldDefault(
                    hint: 'num_8'.tr,
                    errorText: "must_enter_tax_record_num".tr,
                    controller: darayebController,
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
                      child: widget.taxRegisterNumberImage.isEmpty
                          ? _.taxisNumberImage == null
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
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5.r),
                              child: Stack(
                                children: [
                                  ImageNetwork(
                                    url: widget.taxRegisterNumberImage,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  43.0.ESH(),
                  ButtonDefault(
                    title: "contain_".tr,
                    onTap: () {
                      _.updatePersonalInfo(
                          commercialRegistrationNumber: darayebController!.text,
                          adminName: nameController!.text,
                          taxAuthorityNumber: taxisController!.text,
                      );
                    },
                  ),
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
