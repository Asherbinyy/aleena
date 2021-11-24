import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/custom_drawer_screen.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/LastOrdersScreen/last_orders_screen.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/image_network.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bars.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer:  CustomDrawerScreen(),
        body: ScaffoldBackground(),
      ),
    );
  }
}
