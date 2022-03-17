

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/change_notifiy_status_repo.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/change_password_repo.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/fetch_delivery_fee_repo.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../HomeFeature/ui/screens/add_order.dart';


class FetchDeliveryFeeController extends GetxController{
  final  FetchDeliveryFeeRepository _fetchDeliveryFeeRepository = FetchDeliveryFeeRepository();
  void fetchDeliveryFee({required double lat ,required double lon ,required String address,VoidCallback? onSuccess ,int areaId =0}) async{
    setLoading();
    var response = await _fetchDeliveryFeeRepository.fetchDeliveryFee(lat: lat,lon: lon,areaId:areaId);
    Get.back();
      if(response.statusCode == 200 && response.data['status'] ==true){
          if(response.data['data']!=null){
            // onSuccess!();
            Get.off(()=>AddOrderScreen(address: address, lat: lat, lon: lon,fee:response.data['data'].toString(),inside: response.data['key']??true,));
          }else{
            customSnackBar(title: "Error_".tr,subtitle:response.data['message']??' ');
          }
      }
      else{
        customSnackBar(title: "Error_".tr,subtitle:'Error in change notification status 1');
      }
  }

}