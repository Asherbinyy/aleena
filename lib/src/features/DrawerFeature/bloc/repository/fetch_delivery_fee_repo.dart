import 'dart:io';

import 'package:aleena/src/core/constants/api_key.dart';
import 'package:aleena/src/core/services/network_services.dart';
import 'package:aleena/src/core/utils/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class FetchDeliveryFeeRepository with ApiKey {
  // GetStorage box = GetStorage();
  NetworkService _networkService = NetworkService();

  Future<Response> fetchDeliveryFee({
    required double lat,
    required double lon,
    int areaId =0
  }) async {
    Response response;
    try {
      response = await _networkService
          .post(
          url: uRLFetchDeliveryFee,
          auth: true,
          body: {
            'lat': lat,
            'lng': lon,
            'area_id': areaId
          });
    } on SocketException {
      throw const SocketException('No Internet Connection');
    } on Exception {
      throw UnKnownException('there is unKnown Exception');
    } catch (e) {
      throw UnKnownException(e.toString());
    }
    return response;
  }
}
