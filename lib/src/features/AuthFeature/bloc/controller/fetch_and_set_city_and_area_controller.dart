

import 'package:aleena/src/bloc/controllers/phone_verify_controller.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verify_phone_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/model/city_model.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/area_repo.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/city_repo.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_city_and_area_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class FetchAndSetCityAndAreaController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController? cityController= TextEditingController();
  TextEditingController? areaController= TextEditingController();
  TextEditingController? addressController= TextEditingController();

  List<CityModel> _cityList=[];
  List<CityModel>? get cityList => _cityList;
  int? _citySelected;
  int? get citySelected => _citySelected;
  // String? _citySelectedTitle;
  // String? get citySelectedTitle => _citySelectedTitle;
  set setCitySelectedId(int value) {
    _citySelected = value;
    update();
  }
  set setCitySelectedTitle(String? value) {
    // _citySelectedTitle = value;
    cityController!.text=value!;
    update();
  }

  int? _areaSelectedId;
  int? get areaSelectedId => _areaSelectedId;
  set setAreaSelectedId(int value) {
    _areaSelectedId = value;
    update();
  }
  int? _areaSelectedTitle;
  int? get areaSelectedTitle => _areaSelectedTitle;
  set setAreaSelectedTitle(String value) {
    areaController!.text = value;
    update();
  }

  CityRepository _cityRepository = CityRepository();
  void fetchCity() async{
      // setLoading();
      status = RequestStatus.loading;
      var response = await _cityRepository.fetchCity();
      // Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        _cityList.clear();
        print("request operation success");
        if(response.data['data']!=null){
          for(var item in response.data['data']){
            _cityList.add(CityModel.fromJson(item));
          }
        }
        print("convert operation success");
        status = RequestStatus.done;
        update();
      }else{
        status = RequestStatus.done;
        update();
        // snackBarDefault(title: response.data['message']??' ',errorMessage: true);
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }
  }

  List<CityModel> _areaList=[];
  List<CityModel>? get areaList => _areaList;
  AreaRepository _areaRepository = AreaRepository();

  void fetchArea({required int cityId}) async{
      // setLoading();
      status = RequestStatus.loading;
      var response = await _areaRepository.fetchArea(cityId:cityId );
      // Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        _areaList.clear();
        print("request operation success");
        if(response.data['data']!=null){
          for(var item in response.data['data']){
            _areaList.add(CityModel.fromJson(item));
            update();
          }
        }
        print("convert operation success");
        status = RequestStatus.done;
        update();
      }else{
        status = RequestStatus.done;
        update();
        // snackBarDefault(title: response.data['message']??' ',errorMessage: true);
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }
  }

  SetCityAndAreaRepository _setCityAndAreaRepository = SetCityAndAreaRepository();
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      var response = await _setCityAndAreaRepository.setCityAndArea(areaId:_areaSelectedId,cityId: _citySelected);
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        if(response.data['data']!=null){
          Get.offAll(()=>WaitingConfirmationScreen());
        }
        print("convert operation success");
        status = RequestStatus.done;
        update();
      }else{
        status = RequestStatus.done;
        update();
        // snackBarDefault(title: response.data['message']??' ',errorMessage: true);
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCity();
    cityController = TextEditingController();
    areaController = TextEditingController();
    addressController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController?.dispose();
    areaController?.dispose();
    addressController?.dispose();
  }


}