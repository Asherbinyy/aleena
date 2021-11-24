

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/check_phone_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/verify_phone_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_info_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class VerifyPhoneController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? phoneController;
  bool phoneNotEmpty =  false;
  GetStorage box = GetStorage();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  VerifyPhoneRepository _verifyPhoneRepository = VerifyPhoneRepository();
  Future<void> verifyPhone({bool isRegister=true}) async{
    setLoading();
    var response = await _verifyPhoneRepository.verifyPhone();
    Get.back();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      if(response.data['data']!=null){
        if(isRegister){
          Get.offAll(RegisterInfoScreen());
        }else{
          Get.offAll(LoginScreen());
        }
        // box.write('name',response.data['data']['name']??' ');
        // box.write('phone',response.data['data']['phone']??' ');
        // box.write('email',response.data['data']['email']??' ');
        // box.write('responsableName',response.data['data']['responsable_name']??' ');
        // box.write('commericalRegisterNumber',response.data['data']['commerical_register_number']??' ');
        // box.write('taxRegisterNumber',response.data['data']['tax_register_number']??' ');
        // box.write('taxRegisterNumber',response.data['data']['tax_register_number']??' ');
        // box.write('token',response.data['data']['token']??' ');
        // box.write('token',response.data['data']['token']??' ');
        // box.write('deviceType',response.data['data']['device_type']??' ');
        // box.write('image',response.data['data']['image']??' ');
        // box.write('phoneVerify',response.data['data']['phone_verify']??0);
      }
      print("convert operation success");
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.done;
      update();
      customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
    }
  }

  // void onForgetPassword(){
  //   Get.to(()=>CheckPhoneScreen());
  // }
  //
  // void moveToRegister(){
  //   // Get.back();
  //   Get.to(()=>RegisterScreen());
  // }

}