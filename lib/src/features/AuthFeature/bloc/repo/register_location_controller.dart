

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_info_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_location_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/ConfirmAddressButtonSheet/confirm_address_button_sheet.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class RegisterLocationController extends GetxController{
  RequestStatus status= RequestStatus.initial;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  SetLocationRepository _setLocationRepository = SetLocationRepository();
  void submit({double? lat , double? lon,String? address}) async{
    setLoading();
    status = RequestStatus.loading;
    var response = await _setLocationRepository.setLocation(
      lat: lat,
      lon: lon,
      address:address,
    );
    Get.back();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      if(response.data['data']!=null){
        Get.dialog(ShopAddressButtonSheet());
        // Get.offAll(()=>WaitingConfirmationScreen());
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