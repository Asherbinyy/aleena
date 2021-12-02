
import 'dart:async';

import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';




class SplashController extends GetxController{
  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    // TODO Start Splash Code
    Timer(Duration(seconds: 3), () {
      if(box.read('WaitingConfirmationScreen')== 1&&box.read("active")==1){

      }
      else if(box.hasData('login')&&box.read("active")==1){
        Get.offAll(()=>HomeScreen());
      }else{
        Get.offAll(()=>LoginScreen());
        print("aaaaaaaaaaaaaaaaaaaaaaaa");
      }
    });
    update();
  }
}
