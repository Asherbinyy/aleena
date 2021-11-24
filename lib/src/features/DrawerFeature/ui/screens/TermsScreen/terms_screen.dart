import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/model/qustions_model.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/contact_with_us_by_gmail.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/questions_form.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/who_are_we_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class TermsScreen extends StatelessWidget {
  final List<QuestionsModel> termsList;
  TermsScreen({required this.termsList});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScaffoldBackground(
          appBar: AppBarBack(
            title: 'terms_and_condition'.tr,
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              children: [
                30.0.ESH(),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => WohAreWeForm(
                      answer:termsList[index].answer,
                      questions: termsList[index].qustion),
                  itemCount: termsList.length,
                ),
                24.0.ESH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

