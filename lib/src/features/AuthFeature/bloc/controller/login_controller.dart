

import 'package:aleena/src/bloc/controllers/phone_verify_controller.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/set_location_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verfication_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verify_phone_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/login_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_location_controller.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/phone_input_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_info_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/wating_chick_info_update_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class LoginController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? phoneController;
  TextEditingController? passwordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  LoginRepository _loginRepository = LoginRepository();
  GetStorage box = GetStorage();
  VerifyPhoneController verifyPhoneController = Get.put(VerifyPhoneController());
  RegisterLocationController registerLocationController = Get.put(RegisterLocationController());
  void submit() async{
    print("step 1 ");
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      print('my phone is ${phoneController!.value.text}');
      print('my phone is ${passwordController!.value.text}');
      String phone = phoneController!.value.text;
      print("step 2 ");
      if(phoneController!.value.text.isNotEmpty){
        print("step 3 ");
        if(phoneController!.value.text.startsWith('0')){
          phone = phoneController!.value.text.replaceFirst('0','');
          print("step 4 ");
        }
      }
      print("step 4+ ");

      var response = await _loginRepository.login(phone: phoneController!.value.text,password: passwordController!.value.text);
      print("step 4++ ");
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("step 5 ");
        print("request operation success");
        if(response.data['data']!=null){
          box.write('alternativeـapi_token',response.data['data']['token']);
          box.write('apiToken',response.data['data']['token']);
          box.write('name',response.data['data']['name']);
          box.write('avatarShop',response.data['data']['image']);
          box.write('apiToken',response.data['data']['token']);
          if(response.data['data']['phone_verify']!=1){
            PhoneVerifyController.verifyPhone(phone: phoneController!.text,onSuccess: ()async{
              await verifyPhoneController.verifyPhone();
            });
          }
          else if(response.data['data']['set_info']!=1){
           Get.offAll(()=>RegisterInfoScreen());
          }
          else if(response.data['data']['set_location']==0){
            Get.offAll(()=>MapScreen(
              onSave:  (lat, lon, address){
                registerLocationController.submit(lat: lat,lon: lon,address: address);
              },
            ));
          } else if(response.data['data']['active']==0&&response.data['data']['set_location']==2){
            Get.offAll(()=>WatingChickInfoUpdateScreen());
          }else if(response.data['data']['active']==0){
            Get.offAll(()=>WaitingConfirmationScreen());
          }
          else{
            box.write('name',response.data['data']['name']??' ');
            box.write('phone',response.data['data']['phone']??' ');
            box.write('email',response.data['data']['email']??' ');
            box.write('responsableName',response.data['data']['responsable_name']??' ');
            box.write('commericalRegisterNumber',response.data['data']['commerical_register_number']??' ');
            box.write('taxRegisterNumber',response.data['data']['tax_register_number']??' ');
            box.write('token',response.data['data']['token']??' ');
            box.write('deviceType',response.data['data']['device_type']??' ');
            box.write('image',response.data['data']['image']??' ');
            box.write('phoneVerify',response.data['data']['phone_verify']??0);
            box.write('setInfo',response.data['data']['set_info']??0);
            box.write('setLocation',response.data['data']['set_location']??0);
            box.write('active',response.data['data']['active']??0);
            box.write('login',1);
            Get.offAll(()=>HomeScreen());
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
  }


  void onForgetPassword(){
    Get.to(()=>PhoneInputScreen());
  }

  void moveToRegister(){
    // Get.back();
    Get.to(()=>RegisterScreen());
  }

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }


  @override
  void dispose() {
    phoneController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}