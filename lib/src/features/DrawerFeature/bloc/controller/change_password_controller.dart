

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/change_password_repo.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class ChangePasswordController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? oldPasswordController;
  TextEditingController? newPasswordController;
  TextEditingController? confirmPasswordController;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ChangePasswordRepository _changePasswordRepository =ChangePasswordRepository();
  void changePassword() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      var response = await _changePasswordRepository.changePassword(oldPassword: oldPasswordController!.text, newPassword: newPasswordController!.text);
      setLoading();
      print('my oldPasswordController is ${oldPasswordController!.value.text}');
      print('my newPasswordController is ${newPasswordController!.value.text}');
      print('my confirmPasswordController is ${confirmPasswordController!.value.text}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }


  @override
  void dispose() {
    oldPasswordController?.dispose();
    newPasswordController?.dispose();
    confirmPasswordController?.dispose();
    super.dispose();
  }
}