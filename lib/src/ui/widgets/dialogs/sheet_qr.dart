import 'package:aleena/src/bloc/controllers/set_rate_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/row_top_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/src/core/utils/extensions.dart';

class SheetQr extends StatelessWidget {
  final String qr;

  SheetQr({required this.qr});

  @override
  Widget build(BuildContext context) {
    SetRateController _setRateController = Get.put(SetRateController());
    var node = FocusScope.of(context);
    return Container(
      width: double.infinity,
      height: 660.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(19.r),
            topRight: Radius.circular(19.r),
          ),
          color: Colors.white
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  24.0.ESH(),
                  RowTopBottomSheet(title: "QR",),
                  32.0.ESH(),
                  Center(
                    child: QrImage(
                      data: qr,
                      version: QrVersions.auto,
                      size: 288.sp,
                    ),
                  ),
                  24.0.ESH(),
                ],
              ),
              CustomText(text: "scan_GR".tr,fontW: FW.semibold,),
              16.0.ESH(),
            ],
          ),
        ),
      ),
    );
  }
}

