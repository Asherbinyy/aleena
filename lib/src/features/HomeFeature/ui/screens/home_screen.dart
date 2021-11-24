import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_location_controller.dart';
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

class   HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    RegisterLocationController registerLocationController = Get.put(RegisterLocationController());
    return Scaffold(
      drawer:  CustomDrawerScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Get.to(()=>AddOrderScreen());
          homeController.gotoMap();
        },
        backgroundColor: KCMain,
        child: Center(
          child: Image.asset(
            'assets/icons/float.png',
            color: Colors.white,
            height: 29.h,
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) => ScaffoldBackground(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
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
                  onTap: (index){
                    _.tabIndex = index;
                  },
                  status: _.tabIndex,
                ),
                26.0.ESH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: _.tabIndex==0 ? 'waiting_order'.tr: 'delivering_order'.tr,
                      fontW: FW.bold,
                      color: KCMainBlack,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: (_.status == RequestStatus.done)? '(${_.tabIndex==0 ? _.waitingOrders.length : _.underDelivery.length} ${"order_".tr})':'',
                      fontW: FW.bold,
                      color: KCMainGrey,
                      fontSize: 12,
                    ),
                  ],
                ),
                Expanded(
                    child:
                    _.status != RequestStatus.done?
                        0.0.ESH():
                    (_.tabIndex == 0 && _.waitingOrders.isEmpty || _.tabIndex == 1 && _.underDelivery.isEmpty)?
                    Center(
                      child: EmptyWidget(
                        image: 'open.png',
                        title: 'no_waiting_order'.tr,
                        subtitle: 'no_delivering_order_add_order_first'.tr,
                      ),
                    ):
                    RefreshIndicator(
                      onRefresh: ()async{
                        _.fetchHome(refresh: true);
                      },
                      child: ListView.separated(
                          itemBuilder: (context, index) => _.tabIndex==0 ?
                          CardOrder(order: _.waitingOrders[index],) :
                          CardFinishOrder(
                            order: _.underDelivery[index],isHome: true,
                            onReview: (){
                              Get.bottomSheet(SheetRate(order:_.underDelivery[index]), isScrollControlled: true);
                            },
                          ),
                          separatorBuilder: (context, index) => 16.0.ESH(),
                          itemCount: _.tabIndex==0 ? _.waitingOrders.length:_.underDelivery.length,
                          shrinkWrap: true,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
