

import 'package:aleena/src/bloc/controllers/phone_verify_controller.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verify_phone_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_repository.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class RegisterController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  GetStorage box = GetStorage();
  VerifyPhoneController verifyPhoneController = Get.put(VerifyPhoneController());
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  RegisterRepository _registerRepository = RegisterRepository();
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      print('my phone is ${nameController!.value.text}');
      print('my phone is ${phoneController!.value.text}');
      print('my phone is ${passwordController!.value.text}');
      print('my phone is ${confirmPasswordController!.value.text}');
      // String phone = phoneController!.value.text;
      // if(phoneController!.value.text.isNotEmpty){
      //   if(phoneController!.value.text.startsWith('0')){
      //     phone = phoneController!.value.text.replaceFirst('0','');
      //   }
      // }
      var response = await _registerRepository.register(
          phone: phoneController!.text,
          password: passwordController!.text,
          name: nameController!.text
      );
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        if(response.data['data']!=null){
          box.write('alternativeـapi_token',response.data['data']['token']);
          box.write('apiToken',response.data['data']['token']);
          print("apiToken in register >>>>>>>>>:-> ${box.read('alternativeـapi_token')}");
          PhoneVerifyController.verifyPhone(phone: phoneController!.text,onSuccess: ()async{
            await verifyPhoneController.verifyPhone();
          });
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
  void moveToLogin(){
    // Get.back();
    Get.offAll(()=>LoginScreen());
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }


  @override
  void dispose() {
    nameController?.dispose();
    phoneController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    super.dispose();
  }
}