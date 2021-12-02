
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/change_notifiy_status_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




class GeneralSettingRowNotificationForm extends StatelessWidget {
// final bool notifyStatus;
//
// GeneralSettingRowNotificationForm({required this.notifyStatus});

  @override
  Widget build(BuildContext context) {
    // print("notifyStatus $notifyStatus");
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
          GetBuilder<ChangeNotifyStatusController>(
            builder: (_) => Switch(
              activeColor: KCBlueMenu,
              value: _.isNotifyActive!,
              onChanged: (bool newValue) {
                _.changeIsNotifyStatus(status:newValue==false?0:1,onSuccess: (){
                  customSnackBar(title: "Done_".tr,subtitle:'Change Notification Status Successfully');
                });
                _.changeIsNotifyActive =newValue;
                // if(newValue){
                //   _.changeIsNotifyActive= !(_.isNotifyActive!);
                //   _.changeIsNotifyStatus( status:1);
                // }else{
                //   _.changeIsNotifyActive= !(_.isNotifyActive!);
                //   _.changeIsNotifyStatus( status:0);
                // }
              },
            ),),
        ],
      ),
    );
  }
}
