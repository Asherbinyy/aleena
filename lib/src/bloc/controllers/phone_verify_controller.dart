
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/verfication_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



String handlePhone(String phone){
  if(phone.startsWith('01')||phone.startsWith('1')){
    return phone.startsWith("0") ? "+2$phone" : "+20$phone";
  }else{
    if(phone.startsWith("0")){
      return phone.replaceFirst('0','+966');
    }else{
      return  "+966$phone";
    }
  }
}


class PhoneVerifyController{
  static Future<bool?>? verifyPhone({String? phone, Function? onSuccess,bool isRegister = true}) async {
    var _auth = FirebaseAuth.instance;
    setLoading();
    _auth.verifyPhoneNumber(
      phoneNumber: handlePhone(phone!),
      //   phoneNumber: "",
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          onSuccess!();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          // if(e != null){
          //   if(e.toString().contains("The SMS verification code used to create the phone auth credential is invalid")){
          //   snackBarDefault(errorMessage: true,title: 'تاكد من كتابة الكوة الصحيح');
          //   }
          // }
          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.back(); // to remove loading when code sent
          print("code sent");
          Get.offAll( VerficationScreen(
            phone: phone,
            register: isRegister,
            validationCode: verificationId,
            onSuccess: (String validationCode, String code) async {
              setLoading();
              AuthCredential credential = PhoneAuthProvider.credential(verificationId: validationCode, smsCode: code);
              UserCredential result = await _auth.signInWithCredential(credential);
              var user = result.user;
              Get.back();
              if (user != null){
                print("success verfication");
                onSuccess!();
              } else {
                print("an error occur");
              }
            },
          ));
        },
        codeAutoRetrievalTimeout: (data) {});
  }
}
