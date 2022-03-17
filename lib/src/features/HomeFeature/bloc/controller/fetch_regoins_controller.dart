

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/fetch_regions_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bloc/models/region.dart';
import '../../../DrawerFeature/bloc/controller/fetch_delivery_fee_controller.dart';


class FetchRegoinsController extends GetxController{
  List<Region> regoins = [];

  RequestStatus status= RequestStatus.initial;

  FetchRegoinsRepository _fetchRegoinsRepository = FetchRegoinsRepository();
  Future<void> fetchRegoins({bool refresh=false})async{
    status = RequestStatus.loading;
    update();
    var response = await _fetchRegoinsRepository.fetchRegoins();
    // var response = await _homeRepository.home();
    if (response.statusCode == 200 && response.data["status"] == true) {
      debugPrint("request operation success11111");
      regoins.clear();
        for (var item in response.data['data']) {
          regoins.add(Region.fromJson(item));
        }
      debugPrint("convert operation success");
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
    fetchRegoins();
  }

}