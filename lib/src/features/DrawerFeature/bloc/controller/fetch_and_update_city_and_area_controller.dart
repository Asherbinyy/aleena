import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/model/city_model.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/area_repo.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/city_repo.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/update_city_and_area.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'log_out_controller.dart';


class FetchAndUpdateCityAndAreaController extends GetxController{
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

  UpdateCityAndAreaRepository _updateCityAndAreaRepository =UpdateCityAndAreaRepository();
  LogOutController _logOutController =Get.put(LogOutController());
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      var response = await _updateCityAndAreaRepository.updateCityAndArea(areaId:_areaSelectedId,cityId: _citySelected);
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        if(response.data['data']!=null){
          _logOutController.logOut();
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
  //
  // void updateAddress() async {
  //   setLoading();
  //   status = RequestStatus.loading;
  //   var response = await _updateCityAndAreaRepository.updateCityAndArea(
  //       areaId:_areaSelectedId,cityId: _citySelected
  //   );
  //   Get.back();
  //   if (response.statusCode == 200 && response.data["status"] == true) {
  //     print("request operation success");
  //
  //     Get.offAll(() => LoginScreen());
  //
  //     print("convert operation success");
  //     status = RequestStatus.done;
  //     update();
  //     customSnackBar(
  //         title: "Done_".tr, subtitle: 'update_personal_profile_info_down'.tr);
  //   } else {
  //     status = RequestStatus.done;
  //     update();
  //     customSnackBar(
  //         title: "Error_".tr, subtitle: response.data['message'] ?? ' ');
  //   }
  // }
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