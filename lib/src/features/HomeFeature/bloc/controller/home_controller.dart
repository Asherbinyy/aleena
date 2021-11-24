

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeController extends GetxController{
  List<Order> waitingOrders = [];
  List<Order> underDelivery = [];
  int _tabsIndex = 0;
  int get tabsIndex => _tabsIndex;
  set tabsIndex(int value) {
    _tabsIndex = value;
    update();
  }

  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  set tabIndex(int value) {
    _tabIndex = value;
    update();
  }

  RequestStatus status= RequestStatus.initial;

  HomeRepository _homeRepository = HomeRepository();
  Future<void> fetchHome({bool refresh=false})async{
    if(!refresh){
      status = RequestStatus.loading;
    }
    update();
    var response = await _homeRepository.home();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
        waitingOrders.clear();
        underDelivery.clear();
        for (var item in response.data['waitingOrder']) {
           waitingOrders.add(Order.fromJson(item));
        }
        for (var item in response.data['underdeliveryOrder']) {
           underDelivery.add(Order.fromJson(item));
        }

      print("convert operation success");
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.error;
      update();
    }
  }


  Future<void> gotoMap()async{
    setLoading();
    LatLng? position = await getMyLocation();
    Get.back();
    Get.to(()=>MapScreen(
      targetPosition: position,
      onSave: (double lat , double lon , String address){
        Get.to(()=>AddOrderScreen(address: address, lat: lat, lon: lon,));
      },));
  }



  Future<LatLng?>? getMyLocation()async{
    await Geolocator.getCurrentPosition().then((value) {
      return value;
    });
    try{
      var pos =  await Geolocator.getCurrentPosition();
      return LatLng(pos.latitude, pos.longitude);
    }catch(e){
      return LatLng(24.774265,46.738586);
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchHome();
  }

}