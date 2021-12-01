import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/buttons/button_circle.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/cards/delivery_order_card.dart';
import 'package:aleena/src/ui/widgets/dialogs/sheet_qr.dart';
import 'package:aleena/src/ui/widgets/titles/title_card_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';

class CardFinishOrder extends StatelessWidget {
  final VoidCallback? onReviewTap;
  final VoidCallback? onCallTap;
  final Order? order;
  final bool isHome;
  final bool isRate;


  CardFinishOrder({this.onReviewTap,this.onCallTap , this.order, this.isHome = false, this.isRate=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Container(
        width: 343.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.transparent,
            border: Border.all(color: KCMainBorder, width: 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              DeliveryOrderCard(
                order: order,
                onRateTap: onReviewTap ?? () {},
                onCallTap: onCallTap??(){},
                isRate: isRate,
              ),
              16.0.ESW(),
              Divider(),
              16.0.ESW(),
              Row(
                children: [
                  CustomText(
                    text: 'order_details'.tr,
                    fontSize: 13,
                    color: KCMainBlack,
                    fontW: FW.medium,
                  ),
                ],
              ),
              8.0.ESH(),
              TitleCardOrder(
                title: '${"clint_name".tr} : ',
                subtitle: order!.clientName,
              ),
              8.0.ESH(),
              TitleCardOrder(
                title: '${"order_number".tr} : ',
                subtitle: '#${order!.orderNumber}',
              ),
              8.0.ESH(),
              TitleCardOrder(
                title: order!.duration??"00:00",
              ),
              8.0.ESH(),
              TitleCardOrder(
                title: '${"address_".tr} : ',
                subtitle: order!.address,
              ),
              8.0.ESH(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleCardOrder(
                    title: '${"order_price".tr} : ',
                    subtitle: '${order!.price} ${"SAR_".tr}',
                  ),
                  CustomText(
                    text: order!.paymentMethod == 'cash'
                        ? '( ${"payment_cash".tr} )'
                        : '( ${"payment_online".tr} )',
                    fontSize: 10,
                    fontW: FW.light,
                    color: KClightGrey,
                  ),
                ],
              ),
              !isHome
                  ? 0.0.ESH()
                  : Padding(
                      padding: EdgeInsets.only(top: 12.0.h),
                      child: ButtonDefault(
                        title: 'confirm_delivery'.tr,
                        onTap: (){
                          Get.bottomSheet(
                            SheetQr(qr: order!.qrCode.toString(),),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
