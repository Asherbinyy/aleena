

import 'package:aleena/src/bloc/controllers/phone_verify_controller.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/check_phone_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/reset_password_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class CheckPhoneController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? phoneController;
  bool phoneNotEmpty =  false;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  CheckPhoneRepository _checkPhoneRepository = CheckPhoneRepository();
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      print('my phone in CheckPhoneController is ${phoneController!.value.text}');
      var response = await _checkPhoneRepository.checkPhone(phone: phoneController!.text);
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        if(response.data['data']!=null){
          if(response.data['data']==true){
            PhoneVerifyController.verifyPhone(phone: phoneController!.text , isRegister: false ,onSuccess: (){
              Get.offAll(()=>ResetPasswordScreen(phone: phoneController!.text ,));
            });
          }else{
            customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
          }
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
  }

  // void onForgetPassword(){
  //   Get.to(()=>CheckPhoneScreen());
  // }
  //
  // void moveToRegister(){
  //   // Get.back();
  //   Get.to(()=>RegisterScreen());
  // }

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    phoneController!.addListener(() {
      if(phoneController!.text.isNotEmpty){
        phoneNotEmpty = true;
      }else{
        phoneNotEmpty = false;
      }
      update();
    });
  }


  @override
  void dispose() {
    phoneController?.dispose();
    super.dispose();
  }
}