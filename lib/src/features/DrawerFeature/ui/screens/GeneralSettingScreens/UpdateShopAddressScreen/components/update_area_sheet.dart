import 'package:aleena/src/bloc/controllers/set_rate_controller.dart';
import 'package:aleena/src/bloc/models/lang_model.dart';
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/fetch_and_set_city_and_area_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/model/city_model.dart';
import 'package:aleena/src/features/AuthFeature/ui/widgets/city_or_area_form.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/fetch_and_update_city_and_area_controller.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/controller/lang_controller.dart';
import 'package:aleena/src/features/DrawerFeature/ui/widgets/row_lang_form.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/row_top_bottom_sheet.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/src/core/utils/extensions.dart';

class UpdateAreaButtonSheet extends StatelessWidget {
  final List<CityModel> areaList;

  const UpdateAreaButtonSheet({Key? key, required this.areaList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FetchAndUpdateCityAndAreaController _fetchAndUpdateCityAndAreaController = Get.put(FetchAndUpdateCityAndAreaController());
    var node = FocusScope.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(19.r),
          topRight: Radius.circular(19.r),
        ),
        child: Container(
          width: double.infinity,
          height: 500.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19.r),
                topRight: Radius.circular(19.r),
              ),
              color: Colors.white),
          child: GetBuilder<FetchAndUpdateCityAndAreaController>(
            builder: (_) => Column(
              children: [
                24.0.ESH(),
                RowTopBottomSheet(
                  title: "area_".tr,
                  isClose: false,
                ),
                24.0.ESH(),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                      onTap: (){
                        print("xxxxxxxxxxxxxxxxxxxxxxx");
                        _.setAreaSelectedId = _.areaList![index].id;
                        _.setAreaSelectedTitle =  _.areaList![index].title;
                        Get.back();
                      },
                      child: CityOrAreaRowForm(
                        cityName: areaList[index].title,
                      )),
                  separatorBuilder: (context, index) => Divider(
                    height: 1.5.h,
                    color: KCTFEnableBorder,
                  ),
                  itemCount: areaList.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
