
import 'dart:async';

import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../AuthFeature/ui/screens/waiting_confirm_screen.dart';




class SplashController extends GetxController{
  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      if(box.read('WaitingConfirmationScreen')==1){
        Get.offAll(()=>WaitingConfirmationScreen());
      }
      else if(box.hasData('login')&&box.read("active")==1){
        Get.offAll(()=>HomeScreen());
      }else{
        Get.offAll(()=>LoginScreen());
      }
    });
    update();
  }
}
