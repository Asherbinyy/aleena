import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class SetInfoRepository with ApiKey {
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();
  GetStorage box = GetStorage();

  Future<Response> setInfo({
    required String taxis,
    required String darayeb,
    required String personalName,
    // required FormData? avatar,
  }) async {
    Response response;
    String apiToken =box.read('apiToken');
    try {
      print("apiToken.,.,.,. $apiToken");
      print("taxis.,.,.,. $taxis");
      print("darayeb.,.,.,. $darayeb");
      print("personalName.,.,.,. $personalName");
      response = await _networkService.post(
              url: URLRegisterInfo,
              auth: true,
              body: {
        // "avatar":avatar,
        'responsable_name': personalName,
        'commerical_register_number': darayeb,
        'tax_register_number': taxis,
      });
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
