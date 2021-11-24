
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/change_notification_status_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




class GeneralSettingRowNotificationForm extends StatefulWidget {
  const GeneralSettingRowNotificationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<GeneralSettingRowNotificationForm> createState() => _GeneralSettingRowNotificationFormState();
}

class _GeneralSettingRowNotificationFormState extends State<GeneralSettingRowNotificationForm> {
  @override
  Widget build(BuildContext context) {
   Get.put(ChangeNotifyController());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "notifications_".tr,
            fontW: FW.semibold,
            fontSize: 16,
          ),
          GetBuilder<ChangeNotifyController>(
            builder: (_) => Switch(
              activeColor: KCBlueMenu,
              value: _.giveVerse,
              onChanged: (bool newValue) {
                setState(() {
                  _.giveVerse = newValue;
                  _.changeNotify(notifyStatus: newValue==false?0 :1 );
                });
              },
            ),),
        ],
      ),
    );
  }
}
