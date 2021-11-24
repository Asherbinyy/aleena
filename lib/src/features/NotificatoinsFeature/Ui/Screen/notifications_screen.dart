import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/Controller/notifications_controller.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Ui/Widget/row_notification_widget.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/empty_widget.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificatinsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());
    return SafeArea(
      child: Scaffold(
        body: ScaffoldBackground(
          appBar: AppBarBack(
            title: 'notifications_'.tr,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                30.0.ESH(),
                GetBuilder<NotificationsController>(
                  builder: (_) => _.notificationList.isEmpty
                      ? Center(
                          child: EmptyWidget(
                            image: "open.png",
                            title: "no_notifications_yet".tr,
                            subtitle: "",
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              RowNotificationsWidget(
                            notificationsModel: _.notificationList[index],
                          ),
                          separatorBuilder: (context, index) => Column(
                            children: [
                              16.0.ESH(),
                              const Divider(color: kCMainDivider, height: 1),
                              16.0.ESH(),
                            ],
                          ),
                          itemCount: _.notificationList.length,
                        ),
                ),
                24.0.ESH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
