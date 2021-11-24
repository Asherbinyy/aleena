

import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/model/qustions_model.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/privacy_and_terms_repo.dart';
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


class PrivacyAndTermsController extends GetxController{
  List<QuestionsModel> _privacyList = [];
  List<QuestionsModel> get privacyList => _privacyList;
  List<QuestionsModel> _termsList = [];
  List<QuestionsModel> get termsList => _termsList;
  RequestStatus status= RequestStatus.initial;
  PrivacyAndTermsRepository _privacyAndTermsRepository = PrivacyAndTermsRepository();
  Future<void> fetchPrivacyAndTerms()async{
    var response = await _privacyAndTermsRepository.fetchPrivacyAndTerms();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      _privacyList.clear();
      _termsList.clear();
      if(response.data["data"]["privacy"]!=null){
        for (var item in response.data['data']["privacy"]) {
          _privacyList.add(QuestionsModel.fromJson(item));
        }
      }
      if(response.data["data"]["terms"]!=null){
        for (var item in response.data['data']["terms"]) {
          _termsList.add(QuestionsModel.fromJson(item));
        }
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
    fetchPrivacyAndTerms();
  }
}