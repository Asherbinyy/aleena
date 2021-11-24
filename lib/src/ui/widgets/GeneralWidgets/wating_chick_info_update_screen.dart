

import 'package:aleena/src/ui/widgets/empty_widget.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class WatingChickInfoUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
        needAppBar: false,
        child: EmptyWidget(
          image: 'registersuccess.png',
          title: 'update_address_success_and_waiting_accept_title'.tr,
          subtitle: 'update_address_success_and_waiting_accept_sub_title'.tr,
        ),
      ),
    );
  }
}
