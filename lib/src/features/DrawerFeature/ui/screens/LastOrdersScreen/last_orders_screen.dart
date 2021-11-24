import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/cards/card_finish_order.dart';
import 'package:aleena/src/ui/widgets/dialogs/sheet_rate.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import '/src/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LastOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Scaffold(
      body: ScaffoldBackground(
          // appBar: AppBarBack(title: "",),
          child: ListView.separated(
        itemBuilder: (context, index) => CardFinishOrder(
          order: lastOrder[index],
          onReview: () {
            Get.bottomSheet(SheetRate(order:lastOrder[index]), isScrollControlled: true);
          },
        ),
        separatorBuilder: (context, index) => 16.0.ESH(),
        itemCount: lastOrder.length,
        shrinkWrap: true,
      )),
    );
  }
}
