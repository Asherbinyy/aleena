

import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';


class RegisterRepository with ApiKey{
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();
  Future<Response> register({required String phone , required String password,required String name})async{
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    Response response;
    var deviceToken =  await _firebaseMessaging.getToken();
    print("get deviceToken $deviceToken");
    try{
      response = await _networkService.post(
          url:URLRegister,
          body: {
            'phone': phone,
            'password': password,
            'name': name,
            'device_token': deviceToken,
          }
      );
    }on SocketException{
      throw const SocketException('No Internet Connection');
    }on Exception{
      throw UnKnownException('there is unKnown Exception');
    }catch (e){
      throw UnKnownException(e.toString());
    }
    return response;
  }
}
