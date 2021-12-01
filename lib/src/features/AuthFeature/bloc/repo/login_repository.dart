

import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class LoginRepository with ApiKey{
  // GetStorage box = GetStorage();

  NetworkService _networkService = NetworkService();

  Future<Response> login({required String phone , required String password})async{
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    print("step repo 1 ");
    Response? response;
    var deviceToken =  await _firebaseMessaging.getToken();
    print("get deviceToken $deviceToken");
    try{
      print("step repo 2 ");
      response = await _networkService.post(
          url:URLLogin,
          body: {
            'phone':phone,
            'password':password,
            'device_token':deviceToken,
          }
      );
      print("step repo 3 ");

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
