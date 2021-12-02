

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/change_notifiy_status_repo.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/change_password_repo.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class ChangeNotifyStatusController extends GetxController{
  bool? _isNotifyActive;
  bool? get isNotifyActive => _isNotifyActive;
  set changeIsNotifyActive(bool value) {
    _isNotifyActive = value;
    update();
  }
   ChangeNotifyStatusRepository _changeNotifyStatusRepository =ChangeNotifyStatusRepository();
  void changeIsNotifyStatus({ int? status ,VoidCallback? onSuccess  }) async{
    print("changeIsNotifyStatus step  1");
    // setLoading();
    print("changeIsNotifyStatus step  2");
    var response = await _changeNotifyStatusRepository.changeNotifyStatus(status:status);
    print("changeIsNotifyStatus step  3");
    // Get.back();
      if(response.statusCode == 200 && response.data['status'] ==true){
        print("response.data['noty'] ${response.data['noty']}");
        if(response.data['data']['noty'] !=null){
          print("response.data['data']['noty']  ${response.data['data']['noty'] }");
          _isNotifyActive =response.data['data']['noty']==1?true:false;
          onSuccess!();
        }else{
          customSnackBar(title: "Error_".tr,subtitle:'Error in noty status');
        }
      }
      else{
        customSnackBar(title: "Error_".tr,subtitle:'Error in change notification status 1');
      }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    changeIsNotifyStatus();
    super.onInit();
  }
}