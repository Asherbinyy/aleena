import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/Controller/notifications_controller.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Ui/Widget/row_notification_widget.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/empty_widget.dart';
import 'package:aleena/src/ui/widgets/loading_dialog.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificatinsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationsController _notificationsController =
        Get.put(NotificationsController());
    Future<void> onRefresh() async {
      await _notificationsController.fetchNotifications();
    }

    return SafeArea(
      child: Scaffold(
        body: ScaffoldBackground(
          appBar: AppBarBack(
            title: 'notifications_'.tr,
          ),
          child: GetBuilder<NotificationsController>(
            builder: (_) => _.status == RequestStatus.loading
                ? Scaffold(body: Center(child: LoadingDialog()))
                : _.notificationList.isEmpty
                    ? RefreshIndicator(
                        onRefresh: onRefresh,
                        child: ListView(
                          children: [
                            120.0.ESH(),
                            EmptyWidget(
                              image: "open.png",
                              title: "no_notifications_yet".tr,
                              subtitle: "",
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            30.0.ESH(),
                            RefreshIndicator(
                              onRefresh: onRefresh,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    RowNotificationsWidget(
                                  notificationsModel: _.notificationList[index],
                                ),
                                separatorBuilder: (context, index) => Column(
                                  children: [
                                    16.0.ESH(),
                                    const Divider(
                                        color: kCMainDivider, height: 1),
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
      ),
    );
  }
}
