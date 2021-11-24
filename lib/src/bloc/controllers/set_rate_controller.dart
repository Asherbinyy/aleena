

import 'package:aleena/src/bloc/repositories/set_rate_repository.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/controller/home_controller.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class SetRateController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  SetRateRepository _setRateRepository = SetRateRepository();
  void setRate({required String rate , required String title,required String id}) async{
        status = RequestStatus.loading;
        var response = await _setRateRepository.setRate(rate: rate, title: title, id: id);
        Get.back();
        if (response.statusCode == 200 && response.data["status"] == true) {
          print("request operation success");
          print("convert operation success");
          status = RequestStatus.done;
          update();
          customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
        }else{
          status = RequestStatus.done;
          update();
          customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
        }
  }
}