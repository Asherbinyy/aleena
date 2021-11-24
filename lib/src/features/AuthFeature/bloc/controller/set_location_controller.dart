

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_info_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_location_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class SetLocationController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? nameController;
  TextEditingController? taxisController;
  TextEditingController? darayebController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  SetLocationRepository _setLocationRepository = SetLocationRepository();
  void submit({double? lat , double? lon,String? address}) async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      print('my phone is ${nameController!.value.text}');
      print('my phone is ${taxisController!.value.text}');
      print('my phone is ${darayebController!.value.text}');
      var response = await _setLocationRepository.setLocation(
         lat: lat,
         lon: lon,
         address:address,
      );
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
}