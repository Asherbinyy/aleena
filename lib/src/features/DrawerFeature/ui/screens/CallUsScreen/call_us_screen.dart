import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/qustions_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/contact_with_us_by_gmail.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/questions_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CallUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(QuestionsController());
    return SafeArea(
      child: Scaffold(
        body: ScaffoldBackground(
          appBar: AppBarBack(
            title: 'call_us'.tr,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              children: [
                30.0.ESH(),
                CustomText(
                  text: "Frequently_Asked_Questions".tr,
                  fontSize: 18.sp,
                  fontW: FW.semibold,
                ),
                24.0.ESH(),
                GetBuilder<QuestionsController>(
                  builder: (_) => ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => QuestionsForm(
                      answer: _.questionsList[index].answer,
                      questions: _.questionsList[index].qustion,
                    ),
                    itemCount: _.questionsList.length,
                  ),
                ),
                ContactWithUsByGmail(),
                24.0.ESH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
