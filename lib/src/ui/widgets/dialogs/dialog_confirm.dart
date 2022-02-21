import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';

class DialogConfirm extends StatelessWidget {
  final VoidCallback? onOk;

  DialogConfirm({this.onOk});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 343.w,
          height: 180.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color: Colors.white
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(
                vertical: 32.h
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'هل تريد الغاء الطلب',
                  color: KCMainBlack,
                  fontW: FW.bold,
                  fontSize: 16,
                ),
                33.0.ESH(),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 16.w
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonDefault(
                        width: 120,
                        title: 'نعم',
                        onTap: (){
                          if(onOk!=null){
                            onOk!();
                          }
                        },
                      ),
                      ButtonDefault(
                        width: 120,
                        title: 'لا',
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
