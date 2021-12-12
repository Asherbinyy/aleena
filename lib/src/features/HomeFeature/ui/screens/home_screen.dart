import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_location_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/change_notifiy_status_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/custom_drawer_screen.dart';
import 'package:aleena/src/features/HomeFeature/bloc/controller/home_controller.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/HomeFeature/ui/widgets/order_home_type.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/cards/card_finish_order.dart';
import 'package:aleena/src/ui/widgets/cards/card_order.dart';
import 'package:aleena/src/ui/widgets/dialogs/sheet_rate.dart';
import 'package:aleena/src/ui/widgets/empty_widget.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   Get.put(ChangeNotifyStatusController());
    RegisterLocationController _registerLocationController =
        Get.put(RegisterLocationController());
    HomeController _homeController = Get.put(HomeController());
    Future<void> onRefresh() async {
      await _homeController.fetchHome(refresh: true);
    }
    return SafeArea(
      child: GetBuilder<HomeController>(
        builder: (_) =>  Scaffold(
          drawer: CustomDrawerScreen(),
          floatingActionButton: _.tabIndex ==0 ? FloatingActionButton(
            onPressed: () {
              // Get.to(()=>AddOrderScreen());
              _homeController.gotoMap();
            },
            backgroundColor: KCMain,
            child: Center(
              child: Image.asset(
                'assets/icons/float.png',
                color: Colors.white,
                height: 29.h,
              ),
            ),
          ):null,
          body: ScaffoldBackground(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  22.0.ESH(),
                  CustomText(
                    text: 'welcome_again'.tr,
                    fontSize: 18,
                    fontW: FW.medium,
                    color: KCMainBlack,
                  ),
                  4.0.ESH(),
                  CustomText(
                    text: 'add_more_order_and_see_it'.tr,
                    fontSize: 15,
                    fontW: FW.light,
                    color: KCMainGrey,
                  ),
                  26.0.ESH(),
                  OrderTypeChoice(
                    onTap: (index) {
                      _.tabIndex = index;
                    },
                    status: _.tabIndex,
                  ),
                  26.0.ESH(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: _.tabIndex == 0
                            ? 'waiting_order'.tr
                            : _.tabIndex == 1
                            ? 'delivering_order'.tr
                            : "on_way_order".tr,
                        fontW: FW.bold,
                        color: KCMainBlack,
                        fontSize: 16,
                      ),
                      CustomText(
                        text: (_.status == RequestStatus.done)
                            ? '(${_.tabIndex == 0 ? _.waitingOrders.length : _.tabIndex == 1 ? _.underDelivery.length : _.onWayDelivery.length} ${"order_".tr})'
                            : '',
                        fontW: FW.bold,
                        color: KCMainGrey,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  Expanded(
                    child: _.status != RequestStatus.done
                        ? 0.0.ESH()
                        : (_.tabIndex == 0 && _.waitingOrders.isEmpty ||
                        _.tabIndex == 1 && _.underDelivery.isEmpty ||
                        _.tabIndex == 2 && _.onWayDelivery.isEmpty)
                        ? Center(
                      child: RefreshIndicator(
                        onRefresh: onRefresh,
                        child: ListView(
                          children: [
                            32.0.ESH(),
                            EmptyWidget(
                              image: 'open.png',
                              title: 'no_waiting_order'.tr,
                              subtitle: 'no_delivering_order_add_order_first'.tr,
                            ),
                          ],
                        ),
                      ),
                    )
                        : RefreshIndicator(
                      onRefresh: () async {
                        _.fetchHome(refresh: true);
                      },
                      child: RefreshIndicator(
                        onRefresh: onRefresh,
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                          _.tabIndex == 0
                              ? CardOrder(
                            order: _.waitingOrders[index],
                          )
                              : _.tabIndex == 1
                              ? CardFinishOrder(
                            order: _.underDelivery[index],
                            isHome: true,
                            // onReviewTap: (){
                            //   Get.bottomSheet(SheetRate(order:_.underDelivery[index]), isScrollControlled: true);
                            // },
                            onCallTap: () {
                              print("_.onWayDelivery[index].deliveryPhone ${_.underDelivery[index].deliveryPhone}");
                              _.launchCall(
                                  "tel:+02 ${_.underDelivery[index].deliveryPhone}");
                            },
                          )
                              : CardFinishOrder(
                            order: _.onWayDelivery[index],
                            isHome: false,
                            onCallTap: () {
                              print("_.onWayDelivery[index].deliveryPhone ${_.onWayDelivery[index].deliveryPhone}");
                              _.launchCall(
                                  "tel:+02 ${_.onWayDelivery[index].deliveryPhone}");
                            },
                          ),
                          separatorBuilder: (context, index) =>
                              16.0.ESH(),
                          itemCount: _.tabIndex == 0
                              ? _.waitingOrders.length
                              : _.tabIndex == 1
                              ? _.underDelivery.length
                              : _.onWayDelivery.length,
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
