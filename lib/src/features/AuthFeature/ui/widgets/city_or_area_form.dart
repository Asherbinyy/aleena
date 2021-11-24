
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CityOrAreaRowForm extends StatelessWidget {
  final String cityName;

  const CityOrAreaRowForm({
    required this.cityName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: CustomText(
        text: cityName,
        fontW: FW.semibold,
        fontSize: 24.sp,
      ),
    );
  }
}