

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/model/notification_model.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/repository/notification_reposetory.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class NotificationsController extends GetxController{
  final List<NotificationsModel> _notificationList = [];

  List<NotificationsModel> get notificationList => _notificationList;
  RequestStatus status= RequestStatus.initial;
  NotificationsRepository _notificationsRepository = NotificationsRepository();
  Future<void> fetchNotifications()async{
    update();
    var response = await _notificationsRepository.fetchNotifications();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      _notificationList.clear();
      for (var item in response.data['data']) {
        _notificationList.add(NotificationsModel.fromJson(item));
      }
      print("convert operation success");
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.error;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

}