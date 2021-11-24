

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/model/qustions_model.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/how_are_we_repo.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/questions_repo.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HowAreWeController extends GetxController{
  List<QuestionsModel> _howAreWeList = [];
  List<QuestionsModel> get howAreWeList => _howAreWeList;
  RequestStatus status= RequestStatus.initial;
  HowAreWeRepository _howAreWeRepository = HowAreWeRepository();
  Future<void> fetchHowAreWe({bool refresh=false})async{
    if(!refresh){
      status = RequestStatus.loading;
    }
    update();
    var response = await _howAreWeRepository.fetchHowAreWe();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      _howAreWeList.clear();
      for (var item in response.data['data']) {
        _howAreWeList.add(QuestionsModel.fromJson(item));
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
    fetchHowAreWe();
  }

}