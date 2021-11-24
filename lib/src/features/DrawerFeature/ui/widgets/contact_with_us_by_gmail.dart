import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/contact_with_us_by_gmail_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/questions_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ContactWithUsByGmail extends StatefulWidget {
  const ContactWithUsByGmail({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactWithUsByGmail> createState() => _ContactWithUsByGmailState();
}
class _ContactWithUsByGmailState extends State<ContactWithUsByGmail> {
  ContactWithUsByGmailController _contactWithUsByGmailController = Get.put(ContactWithUsByGmailController());
  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 17.2.w,vertical:25.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color:KCTFEnableBorder.withOpacity(0.80),
      ),
      // height: 333.h,
      width: double.infinity,
      child: GetBuilder<ContactWithUsByGmailController>(
        builder:(_) =>  Form(
          key: _.globalKey,
          child: Column(
            children: [
              TextFieldDefault(
                hint: 'gmail_'.tr,
                errorText: "must_enter_gmail".tr,
                controller: _.gmailController,
                keyboardType: TextInputType.phone,
                filledColor: Colors.white,
                outerHorizentalPadding: 0,
                // upperTitle: 'رقم الجوال',
                // validation: phoneValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
              16.0.ESH(),
              TextFieldDefault(
                hint: 'write_message'.tr,
                errorText: "must_write_message".tr,
                controller: _.messageController,
                filledColor: Colors.white,
                outerHorizentalPadding: 0,
                // upperTitle: 'كلمة المرور',
                maxLines: 5,
                // validation: passwordValidator,
                onComplete: () {
                  node.unfocus();
                  _.submit();
                },
              ),
              32.0.ESH(),
              ButtonDefault(
                title: 'send_'.tr,
                onTap: (){
                  _.submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
