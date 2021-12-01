import 'package:aleena/src/bloc/controllers/set_rate_controller.dart';
import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/image_network.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../star_rate_icon.dart';
import '../custom_snack_bar.dart';
import '/src/core/utils/extensions.dart';

class SheetRate extends StatefulWidget {
  final Order? order;

  SheetRate({required this.order}); // final Function(int,String)? onSave;
  // SheetRate({this.onSave});
  @override
  State<SheetRate> createState() => _SheetRateState();
}

class _SheetRateState extends State<SheetRate> {
  TextEditingController? controller;
  int rate = 0 ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SetRateController _setRateController = Get.put(SetRateController());
    var node = FocusScope.of(context);
    return Container(
      width: double.infinity,
      height: 605.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(19.r),
            topRight: Radius.circular(19.r),
          ),
          color: Colors.white
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            24.0.ESH(),
            CustomText(
              text: 'delivery_rate'.tr,
              color: KCDarkGrey,
              fontW: FW.medium,
              fontSize: 16,
            ),
            42.0.ESH(),
            Container(
              width: 41.w,
              height: 41.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: ImageNetwork(
                url: widget.order!.deliveryImage,
                defaultAvatar: 'assets/icons/Profile.png',
                width: 50.w,
                height: 50.w,
              ),
            ),
            16.0.ESH(),
            CustomText(
              text: widget.order!.deliveryName,
              color: KCDarkGrey,
              fontW: FW.medium,
              fontSize: 16,
            ),
            16.0.ESH(),
            CustomText(
              text: 'thank_you_and_rete_delivery'.tr,
              color: KCDarkGrey,
              fontW: FW.light,
              fontSize: 14,
            ),
            45.0.ESH(),
            StarRateIcons(rate:rate,onTap: (value){setState(() {
              rate = value;
            });},),
            45.0.ESH(),
            Container(
              height: 129.h,
              width: 343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: const Color(0xffF2F2F2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 16.w
                    ),
                    child: TextField(
                      maxLines: 4,
                      controller: controller,
                      decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: 'add_rate'.tr,
                          hintStyle: const TextStyle(
                            color: Color(0xff757D85),
                            fontSize: 14,
                            fontFamily: 'regular',
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            45.0.ESH(),
            ButtonDefault(
              title: "save_".tr,
              onTap: (){
                node.unfocus();
                if(controller!.text.isNotEmpty){
                  _setRateController.setRate(rate: "$rate", title:  controller!.text, id: widget.order!.id!);
                  //   print("11111111");
                //   Get.back();
                //   widget.onSave!(rate,controller!.text);
                }else{
                  print("22222222");
                  customSnackBar(title: "Error_".tr,subtitle: "add_rate_first".tr);
                  // widget.onSave!(rate,' ');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
