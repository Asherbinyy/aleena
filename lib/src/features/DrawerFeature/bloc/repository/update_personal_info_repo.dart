import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class UpdatePersonalRepository with ApiKey {
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();

  Future<Response> updatePersonalInfo({
    required String name,
    // required String address,
    // required String lat,
    // required String lng,
    // required int cityId,
    // required int areaId,
  }) async {
    Response response;
    try {
      response = await _networkService
          .post(url: uRLUpdatePersonalInfo,
          auth: true,
          body: {
        'name': name,
        // 'address': address,
        // 'lat': lat,
        // 'lng': lng,
        // 'city_id': cityId,
        // 'area_id': areaId,
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
