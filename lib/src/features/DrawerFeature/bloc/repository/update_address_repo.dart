import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class UpdateAddressRepository with ApiKey {
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();

  Future<Response> updateAddressInfo({
    required String address,
    required double lat,
    required double lon,
  }) async {
    Response response;
    try {
      response = await _networkService
          .post(url: uRLUpdatePersonalInfo,
          auth: true,
          body: {
            'address': address,
            'lat': lat,
            'lng': lon,
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
