import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ChangeNotifyStatusRepository with ApiKey {
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();

  Future<Response> changeNotifyStatus({
     int? status,
  }) async {
    Response response;
    print("status in repo $status");
    try {
      if(status!=null ){
        print("status in repo step 1");

        response = await _networkService.post(url: uRLChangeStatusNotification,
            auth: true,
            body: {'noty': status,}
            );
        print("status in repo step 2");
      }else{
        print("status in repo step 3");
        response = await _networkService.post(url: uRLChangeStatusNotification,
            auth: true,
            );
        print("status in repo step 4");
      }
    } on SocketException {
      throw SocketException('No Internet Connection');
    } on Exception {
      throw UnKnownException('there is unKnown Exception');
    } catch (e) {
      throw UnKnownException(e.toString());
    }
    return response;
  }
}
