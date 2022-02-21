

import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


class AddOrderRepository with ApiKey{
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();
  Future<Response> addOrder({
    required String orderNumber,
    bool returnable=false,
    required String clientName,
    required String phone,
    required String price,
    required String paymentMethod,
    required String address,
    required double lat,
    required double lng,
    String? mark
   })async{
    Response response;
    try{
      response = await _networkService.post(
          url:URLPostOrder,
        auth: true,
        body: {
            'order_number' : orderNumber,
            'client_name' : clientName,
            'phone' : phone,
            'price' : price,
            'order_type' : paymentMethod,
            'lat' : lat,
            'lng' : lng,
            'address' : address,
            'returnable' : returnable,
          if(mark!=null)
            'mark' : mark,
        }
      );
    }on SocketException{
      throw SocketException('No Internet Connection');
    }on Exception{
      throw UnKnownException('there is unKnown Exception');
    }catch (e){
      throw UnKnownException(e.toString());
    }
    return response;
  }
}
