

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/last_order_repo.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LastOrderController extends GetxController{
  List<Order> lastOrder = [];


  RequestStatus status= RequestStatus.initial;

  LastOrderRepository _lastOrderRepository = LastOrderRepository();
  Future<void> fetchLastOrder()async{
  status = RequestStatus.loading;
    var response = await _lastOrderRepository.fetchLastOrder();
  if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      lastOrder.clear();
      for (var item in response.data['order']) {
        lastOrder.add(Order.fromJson(item));
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
    fetchLastOrder();
  }

}