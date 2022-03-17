

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/controller/home_controller.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class AddOrderController extends GetxController{


   double? lat;
   double? lon;
   String? address;
   String deliveryFee;
   bool inside;


  AddOrderController({this.lat, this.lon, this.address,this.deliveryFee='0',this.inside=true});

  RequestStatus status= RequestStatus.initial;
  TextEditingController? orderNumberController;
  TextEditingController? clientNameController;
  TextEditingController? phoneController;
  TextEditingController? addressController;
  TextEditingController? priceController;
  TextEditingController? markController;
  TextEditingController? deliveryFeeController;
  bool _returnable = false;


  void changeLat(double replaceLat){
    lat = replaceLat;
    update();
  }

   void changeLon(double replaceLon){
     lon = replaceLon;
     update();
   }

   void changeAddress(String replaceAddress){
     address = replaceAddress;
     update();
   }


  bool get returnable => _returnable;

  set returnable(bool value) {
    _returnable = value;
    update();
  }

  String _paymentMethod='';
  HomeController _homeController = Get.find();
  String get paymentMethod => _paymentMethod;
  set paymentMethod(String value) {
    _paymentMethod = value;
    update();
  }
  AddOrderRepository _addOrderRepository = AddOrderRepository();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  void submit() async{

    if(globalKey.currentState!.validate()){
      if(_paymentMethod.isNotEmpty){
        globalKey.currentState!.save();
        setLoading();
        print('my orderNumberController is ${orderNumberController!.value.text}');
        print('my clientNameController is  ${clientNameController!.value.text}');
        print('my phoneController is       ${phoneController!.value.text}');
        print('my addressController is     ${addressController!.value.text}');
        print('my priceController is       ${priceController!.value.text}');

        status = RequestStatus.loading;
        print('my phone is ${phoneController!.value.text}');

        var response = await _addOrderRepository.addOrder(
          address: addressController!.text,
          price: priceController!.text,
          clientName: clientNameController!.text,
          orderNumber: orderNumberController!.text,
          paymentMethod: _paymentMethod,
          phone: phoneController!.text,
          lng: lon??0.0,
          lat: lat??0.0,
          returnable: _returnable,
          mark: markController!.text.isNotEmpty? markController!.text : null,
        );
        Get.back();
        if (response.statusCode == 200 && response.data["status"] == true) {
          print("request operation success");
          if(response.data['data']!=null){
          }
          Get.offAll(()=>HomeScreen());
          _homeController.fetchHome();
          print("convert operation success");
          status = RequestStatus.done;
          update();
        }else{
          status = RequestStatus.done;
          update();
          customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
        }
      }else{
        customSnackBar(title: "Error_".tr,subtitle: 'يجب اختيار طريقة الدفع');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    orderNumberController = TextEditingController();
    clientNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    priceController = TextEditingController();
    markController = TextEditingController();
    deliveryFeeController = TextEditingController();

    if(deliveryFeeController != null){
      // deliveryFeeController!.text = deliveryFee;
      deliveryFeeController!.text = '${inside? '':'خارج المناطق المحددة'} ${deliveryFee}';
    }
    addressController!.text = address??'';
  }


  @override
  void dispose() {
    orderNumberController?.dispose();
    clientNameController?.dispose();
    phoneController?.dispose();
    addressController?.dispose();
    priceController?.dispose();
    markController?.dispose();
    deliveryFeeController?.dispose();
    super.dispose();
  }
}