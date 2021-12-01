import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationBadege extends StatelessWidget {
final int totalNotification;

NotificationBadege({required this.totalNotification});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomText(text: totalNotification.toString(),fontW: FW.semibold,),
    );
  }
}
