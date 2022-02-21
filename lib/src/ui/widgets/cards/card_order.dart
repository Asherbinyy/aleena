import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/ui/widgets/dialog_password_success.dart';
import 'package:aleena/src/features/HomeFeature/bloc/controller/delete_order_controller.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/buttons/button_circle.dart';
import 'package:aleena/src/ui/widgets/dialogs/dialog_confirm.dart';
import 'package:aleena/src/ui/widgets/titles/title_card_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';
import 'package:get/get.dart';
class CardOrder extends StatelessWidget {
  final Order order;
  final bool isCall;
  CardOrder({required this.order,this.isCall=false});
  @override
  Widget build(BuildContext context) {
    DeleteOrderController _deleteOrderController =Get.put(DeleteOrderController());
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.transparent,
        border: Border.all(color: KCMainBorder,width: 1)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h
        ),
        child: Column(
          children: [
            Row(
              children: [
                CustomText(
                  text: 'order_details'.tr,
                  fontSize: 13,
                  color: KCMainBlack,
                  fontW: FW.medium,
                ),
                6.0.ESW(),
                CustomText(
                  text: '${order.id}',
                  fontSize: 13,
                  color: Colors.red,
                  fontW: FW.light,
                ),
                Spacer(),
                // ButtonCircle(icon: 'locationicon.png',onTap: (){},),
                6.0.ESW(),
                ButtonCircleIcons(icon: Icons.delete_forever,onTap: (){
                  print("delete order id ${order.id}");
                  Get.dialog(DialogConfirm(
                    onOk: (){
                      Get.back();
                      _deleteOrderController.deleteOrder(orderId: order.id!);
                    },
                  ));
                },),
              ],
            ),
            8.0.ESH(),
            TitleCardOrder(
              title: '${"clint_name".tr} : ',
              subtitle: order.clientName,
            ),
            8.0.ESH(),
            TitleCardOrder(
              title: '${"order_number".tr} : ',
              subtitle: '#${order.orderNumber}',
            ),
            8.0.ESH(),
            TitleCardOrder(
              title: order.duration??"00:00",
            ),
            8.0.ESH(),
            TitleCardOrder(
              title: '${"address_".tr} : ',
              subtitle: order.address,
            ),
            8.0.ESH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleCardOrder(
                  title: '${"order_price".tr} : ',
                  subtitle: '${order.price} ${"SAR_".tr}',
                ),
                CustomText(
                  text: order.paymentMethod == 'cash'
                      ? '( ${"payment_cash".tr} )'
                      : '( ${"payment_online".tr} )',
                  fontSize: 10,
                  fontW: FW.light,
                  color: KClightGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
