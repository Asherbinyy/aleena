

import 'dart:async';

import 'package:aleena/src/features/AuthFeature/bloc/controller/verify_phone_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerficationController extends GetxController{

  TextEditingController? textEditingController;
  StreamController<ErrorAnimationType>? errorController;
  VerifyPhoneController verifyPhoneController = Get.put(VerifyPhoneController());
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      // setLoadingDialog();
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
    textEditingController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }


  @override
  void dispose() {
    errorController!.close();
    textEditingController!.dispose();
    super.dispose();
  }
}