import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/last_order_controller.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/cards/card_finish_order.dart';
import 'package:aleena/src/ui/widgets/dialogs/sheet_rate.dart';
import 'package:aleena/src/ui/widgets/empty_widget.dart';
import 'package:aleena/src/ui/widgets/loading_dialog.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LastOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LastOrderController _lastOrderController = Get.put(LastOrderController());
    Future<void> onRefresh()async{
      await _lastOrderController.fetchLastOrder();
    }
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
          appBar: AppBarBack(
            title: "Last_orders".tr,
          ),
          child: GetBuilder<LastOrderController>(
            builder: (_) => _.status == RequestStatus.loading
                ? LoadingDialog()
                : _.lastOrder.isEmpty? Center(
              child:  RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  children: [
                    120.0.ESH(),
                    EmptyWidget(
                      image: 'open.png',
                      title: 'no_order_yet_title'.tr,
                      subtitle: 'no_order_yet_sub_title'.tr,
                    ),
                  ],
                ),
              ),
            ): RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.separated(
                      itemBuilder: (context, index) => CardFinishOrder(
                        order: _.lastOrder[index],
                        onReviewTap: () {
                          Get.bottomSheet(SheetRate(order: _.lastOrder[index]),
                              isScrollControlled: true);
                        },
                      ),
                      separatorBuilder: (context, index) => 16.0.ESH(),
                      itemCount: _.lastOrder.length,
                      shrinkWrap: true,
                    ),
            ),
          )),
    );
  }
}
