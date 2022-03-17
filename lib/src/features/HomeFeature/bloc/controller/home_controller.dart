

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bloc/models/region.dart';
import '../../../DrawerFeature/bloc/controller/fetch_delivery_fee_controller.dart';
import '../repo/fetch_regions_repository.dart';


class HomeController extends GetxController{
  List<Order> waitingOrders = [];
  List<Order> underDelivery = [];
  List<Order> onWayDelivery = [];

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
        onWayDelivery.clear();
        for (var item in response.data['waitingOrder']) {
           waitingOrders.add(Order.fromJson(item));
        }
        for (var item in response.data['underdeliveryOrder']) {
           underDelivery.add(Order.fromJson(item));
        }
        for (var item in response.data['onWayOrder']) {
          onWayDelivery.add(Order.fromJson(item));
        }

      print("convert operation success");
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.error;
      update();
    }
  }
  void deleteOrder(index){
    waitingOrders.removeAt(index);
    update();
  }

  void launchCall(command) async {
    if (!await launch(command)) throw 'Could not launch $command';
  }
  FetchDeliveryFeeController _fetchDeliveryFeeController = Get.put(FetchDeliveryFeeController());
  Future<void> gotoMap({Set<Polyline>? polyLines})async{
    print('my poooool is ${polyLines!.length}');
    setLoading();
    LatLng? position = await getMyLocation();
    Get.back();
    Get.to(()=>MapScreen(
      polyLines: polyLines,
      targetPosition: position,
      onSave: (double lat , double lon , String address,areaId){
        // Get.off(()=>AddOrderScreen(address: address, lat: lat, lon: lon,));
        _fetchDeliveryFeeController.fetchDeliveryFee(lat: lat, lon: lon, address: address,areaId:areaId!);
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


  List<Region> regoins = [];

  RequestStatus regoinsStatus= RequestStatus.initial;
  final Set<Polyline> polyline = {};
  FetchRegoinsRepository _fetchRegoinsRepository = FetchRegoinsRepository();
  Future<void> fetchRegoins({bool refresh=false})async{
    regoinsStatus = RequestStatus.loading;
    update();
    var response = await _fetchRegoinsRepository.fetchRegoins();
    // var response = await _homeRepository.home();
    if (response.statusCode == 200 && response.data["status"] == true) {
      debugPrint("request operation success11111");
      regoins.clear();

      for (var item in response.data['data']) {
        print('ahhhhmed $item');
        regoins.add(Region.fromJson(item));
      }
      debugPrint("convert operation successghghgh");
      for(var regoin in regoins){
        print('a7aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        List<LatLng> latLng = [];
        for(var coor in regoin.coordinates!){
          latLng.add(LatLng(coor.lat!, coor.lon!));
          // latLng.add(LatLng(0.0, 0.0));
        }
        polyline.add(Polyline(
            polylineId: PolylineId(regoin.id!.toString()),
            points: latLng,
            color: Colors.red,
            width: 2
        ),);
      }
      regoinsStatus = RequestStatus.done;

      update();
    }else{
      regoinsStatus = RequestStatus.error;
      update();
    }
  }




  @override
  void onInit() {
    super.onInit();
    fetchHome();
    fetchRegoins();
  }

}