import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/model/notification_model.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/dialogs/sheet_rate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RowNotificationsWidget extends StatelessWidget {
  const RowNotificationsWidget({
    required this.notificationsModel,
    Key? key,
  }) : super(key: key);
  final NotificationsModel notificationsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28.sp,
                backgroundColor: notificationsModel.status == 1 ||
                        notificationsModel.status == 2
                    ? Colors.transparent
                    : KCSeconary,
                child: notificationsModel.status == 1 ||
                        notificationsModel.status == 1
                    ? Image.asset(
                        "assets/icons/Profile.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Center(
                        child: ImageIcon(
                            const AssetImage("assets/icons/bickIcon.png"),
                            size: 20.w,
                            color: Colors.white)),
              ),
              8.0.ESW(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // color: Colors.cyan,
                      constraints: BoxConstraints(maxWidth: 220.w),
                      child: CustomText(
                        text: notificationsModel.msg,
                        fontW: FW.bold,
                        fontSize: 18,
                      )),
                  SizedBox(
                    // constraints: BoxConstraints(maxWidth: 200.w),
                    width: 200.w,
                    child: CustomText(
                      text:
                          "${notificationsModel.deliveryName} ${notificationsModel.status == 1 || notificationsModel.status == 1 ? "and_ready_to_delivered".tr : "successfully_".tr}",
                      fontW: FW.semibold,
                      fontSize: 14,
                    ),
                  ),
                  CustomText(
                    text: notificationsModel.time,
                    fontW: FW.regular,
                    fontSize: 12,
                    color: KCTFHintTitle,
                  ),
                ],
              ),
            ],
          ),
          notificationsModel.status != null
              ? ButtonDefault(
                  width: 60,
                  height: 30,
                  radius: 15,
                  title: notificationsModel.status == 1 ||
                          notificationsModel.status == 1
                      ? 'show_'.tr
                      : "rate_".tr,
                  onTap: () {
                    Get.bottomSheet(SheetRate(order: notificationsModel.order),
                        isScrollControlled: true);
                  },
                )
              : 0.0.ESH(),
        ],
      ),
    );
  }
}
