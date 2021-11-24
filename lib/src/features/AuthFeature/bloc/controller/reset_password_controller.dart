

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/reset_password_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/widgets/dialog_password_success.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class ResetPasswordController extends GetxController{

  RequestStatus status= RequestStatus.initial;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ResetPasswordRepository _resetPasswordRepository = ResetPasswordRepository();

  void submit({required String phone}) async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      print('my password is ${passwordController!.value.text}');
      print('my phone in ResetPasswordController is ${phone}');
      // String phone = phoneController!.value.text;
      // if(phoneController!.value.text.isNotEmpty){
      //   if(phoneController!.value.text.startsWith('0')){
      //     phone = phoneController!.value.text.replaceFirst('0','');
      //   }
      // }
      var response = await _resetPasswordRepository.resetPassword(
          phone: phone,password: passwordController!.text);
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        if(response.data['data']!=null){
          Get.offAll(()=>LoginScreen());
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
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }


  @override
  void dispose() {
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    super.dispose();
  }
}