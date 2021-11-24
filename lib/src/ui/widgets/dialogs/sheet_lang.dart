import 'package:aleena/src/bloc/controllers/set_rate_controller.dart';
import 'package:aleena/src/bloc/models/lang_model.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/lang_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/row_lang_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/row_top_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/src/core/utils/extensions.dart';

class SheetLang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(LangController());
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(19.r),
          topRight: Radius.circular(19.r),
        ),
        child: Container(
          width: double.infinity,
          height: 400.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19.r),
                topRight: Radius.circular(19.r),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  24.0.ESH(),
                  RowTopBottomSheet(title: "change_lang".tr),
                  32.0.ESH(),
                  GetBuilder<LangController>(
                    builder:(_) =>  ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            InkWell(
                              onTap: (){
                                _.changeLangIndex(_.langList[index].id);
                                _.changeLang(_.langList[index].id);
                              },
                              child: RowLangChoose(
                                active: _.active==_.langList[index].id,
                                flag:"${_.langList[index].flag}",
                                langTitle: "${_.langList[index].langTitle}",
                              ),
                            ),
                        separatorBuilder: (context, index) => 16.0.ESH(),
                        itemCount: _.langList.length),
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
