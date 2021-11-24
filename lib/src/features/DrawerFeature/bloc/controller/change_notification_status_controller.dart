import 'package:aleena/src/features/DrawerFeature/bloc/repository/change_notification_status_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeNotifyController extends GetxController {
  bool _giveVerse = true;
  bool get giveVerse => _giveVerse;

  set giveVerse(bool value) {
    _giveVerse = value;
  }
  ChangeNotificationsStatusRepository _hangeNotificationsStatusRepository = ChangeNotificationsStatusRepository();
  Future<void> changeNotify({
    required int notifyStatus,
  }) async {
    var response = await _hangeNotificationsStatusRepository.changeNotificationsStatus(notificationsStatus: notifyStatus);
    if (response.statusCode == 200 && response.data["status"] == true) {

    } else {

    }
  }
}
