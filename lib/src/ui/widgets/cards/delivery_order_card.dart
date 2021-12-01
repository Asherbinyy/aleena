import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/image_network.dart';
import 'package:aleena/src/ui/widgets/buttons/button_circle.dart';
import 'package:aleena/src/ui/widgets/buttons/button_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';
import 'package:get/get.dart';

class DeliveryOrderCard extends StatelessWidget {
  final bool isRate;
  final Order? order;
  final VoidCallback? onRateTap;
  final VoidCallback? onCallTap;

  DeliveryOrderCard(
      {this.onRateTap, this.onCallTap, this.order, this.isRate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 41.w,
            height: 41.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: ImageNetwork(
              url: order!.deliveryImage,
              defaultAvatar: 'assets/icons/Profile.png',
              width: 50.w,
              height: 50.w,
            ),
          ),
          16.0.ESW(),
          Column(
            children: [
              CustomText(
                text: 'delivery_'.tr,
                color: KCMainBlack,
                fontW: FW.light,
                fontSize: 11,
              ),
              8.0.ESW(),
              CustomText(
                text: order!.deliveryName,
                color: KCMainBlack,
                fontW: FW.medium,
                fontSize: 13,
              ),
            ],
          ),
          const Spacer(),
          isRate
              ? ButtonRate(
                  onTap: onRateTap ?? () {},
                )
              : ButtonCircle(
                  icon: 'phone.png',
                  onTap: onCallTap ?? () {},),
        ],
      ),
    );
  }
}
