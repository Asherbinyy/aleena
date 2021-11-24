

import 'package:aleena/src/bloc/models/address_model.dart';
import 'package:aleena/src/bloc/models/order.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/shop_repo.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/home_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/add_order.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ShopInfoController extends GetxController{
  late String _name;
  late String _phone;
  late String _email;
  late String _address;
  late String _avatar;
  late String _adminName;
  late String _commericalRegisterNumber;
  late String _taxRegisterNumber;
  late String _commericalRegisterImage;
  late String _taxRegisterImage;
  String get commericalRegisterImage => _commericalRegisterImage;
  RequestStatus status= RequestStatus.initial;
  ShopInfoRepository _shopInfoRepository = ShopInfoRepository();
  Future<void> fetchShopInfo({bool refresh=false})async{
    var response = await _shopInfoRepository.fetchShopInfo();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      print(" response.data :>email ${ response.data["data"]["email"]}");
      print(" response.data :>image ${ response.data["data"]["image"]}");
      var addressResponse =response.data["data"]["address"];
      _name = response.data["data"]["name"] ?? '';
      _phone = response.data["data"]["phone"] ?? '';
      _email = response.data["data"]["email"] ?? "";
      _address = addressResponse["address"] ?? '';
      _adminName = response.data["data"]["responsable_name"] ?? '';
      _commericalRegisterNumber = response.data["data"]["commerical_register_number"] ?? '';
      _commericalRegisterImage = response.data["data"]["com_reg_num_image"] ?? '';
      _taxRegisterNumber = response.data["data"]["tax_register_number"] ?? '';
      _taxRegisterImage = response.data["data"]["tax_reg_num_image"] ?? '';
      _avatar = response.data["data"]["image"] ?? '';
      print("convert operation success");
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.error;
      update();
    }
  }

  String get name => _name;

  @override
  void onInit() {
    super.onInit();
    fetchShopInfo();
  }

  String get phone => _phone;

  String get email => _email;

  String get address => _address;

  String get avatar => _avatar;

  String get adminName => _adminName;

  String get commericalRegisterNumber => _commericalRegisterNumber;

  String get taxRegisterNumber => _taxRegisterNumber;

  String get taxRegisterImage => _taxRegisterImage;
}