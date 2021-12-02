import 'dart:convert';
import 'dart:io';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_location_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_info_repository.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class RegisterInfoController extends GetxController{

  RequestStatus status= RequestStatus.initial;
  TextEditingController? nameController;
  TextEditingController? taxisController;
  TextEditingController? darayebController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  SetInfoRepository _setInfoRepository = SetInfoRepository();
  RegisterLocationController registerLocationController = Get.put(RegisterLocationController());
  GetStorage box = GetStorage();
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      var response = await _setInfoRepository.setInfo(
        // avatar:formData ,
         taxis: taxisController!.text,
        darayeb: darayebController!.text,
        personalName: nameController!.text
      );
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        if(response.data['data']!=null){
          box.write('apiToken',response.data['data']['token']);
          print("set Info Down");
          Get.offAll(()=>MapScreen(
            onSave: (lat, lon, address) {
              registerLocationController.submit(lat: lat,lon: lon,address: address);
              print("set location Down");
            },
          ),);
        }
        print("convert operation success");
        status = RequestStatus.done;
        update();
      }else{
        status = RequestStatus.done;
        update();
        // snackBarDefault(title: response.data['message']??' ',errorMessage: true);
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }
    }
  }

  Future<void> updateCommercialRegisterImage({required File image})async{
    String apiToken = await box.read('apiToken')??box.read('alternativeـapi_token')??' ';
    var uri =
    Uri.parse("https://3leena.com/public/api/shops/updateInfo");
    var request = http.MultipartRequest("POST", uri);
    var stream =  http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var multipartFile1 =  http.MultipartFile('com_reg_num_image', stream, length, filename: basename(image.path), contentType:  MediaType('image', 'png'));
    request.files.add(multipartFile1);
    request.headers.addAll({
      'Authorization' : 'Bearer ' + apiToken,
      // 'Authorization': 'Bearer ' +
      //     "\$2y\$10\$xgbMGXS9hMxvp0QB8yTVXODPxG0dl8DQPG7yUhrhqCv3OVBBjFGNq",
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var data = jsonDecode(res);
      await box.write("com_reg_num_image", data['data']['com_reg_num_image']);
      print("com_reg_num_image>>>>>>>>>:-> ${ data['data']['com_reg_num_image']}");
      return ;
    } else if (response.statusCode == 401) {
      return ;
    }
  }

  File? _commercialRegisterImage;
  File? get commercialRegisterImage => _commercialRegisterImage;
  final picker = ImagePicker();
  Future getCommercialRegisterImage() async {
    await picker.getImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        _commercialRegisterImage = File(value.path);
        update();
      } else {
        print('No image selected.');
      }
      print("_image $_commercialRegisterImage");
      updateCommercialRegisterImage(image: _commercialRegisterImage!);
      // await Provider.of<UserInfoProvider>(context, listen: false).updateImage(image: File(value.path));
    });
  }

  Future<void> updateTaxisNumberImage({required File image})async{
    String apiToken = await box.read('apiToken')??box.read('alternativeـapi_token')??' ';
    var uri =
    Uri.parse("https://3leena.com/public/api/shops/updateInfo");
    var request = http.MultipartRequest("POST", uri);
    var stream =  http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var multipartFile1 =  http.MultipartFile('tax_reg_num_image', stream, length, filename: basename(image.path), contentType:  MediaType('image', 'png'));
    request.files.add(multipartFile1);
    request.headers.addAll({
      'Authorization' : 'Bearer ' + apiToken,
      // 'Authorization': 'Bearer ' +
      //     "\$2y\$10\$xgbMGXS9hMxvp0QB8yTVXODPxG0dl8DQPG7yUhrhqCv3OVBBjFGNq",
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var data = jsonDecode(res);
      await box.write("com_reg_num_image", data['data']['tax_reg_num_image']);
      print("com_reg_num_image>>>>>>>>>:-> ${ data['data']['tax_reg_num_image']}");
      return ;
    } else if (response.statusCode == 401) {
      return ;
    }
  }

  File? _taxisNumberImage;
  File? get taxisNumberImage => _taxisNumberImage;
  Future getTaxisNumberImageImage() async {
    await picker.getImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        _taxisNumberImage = File(value.path);
        update();
      } else {
        print('No image selected.');
      }
      print("_image $_taxisNumberImage");
      updateTaxisNumberImage(image: _taxisNumberImage!);
      // await Provider.of<UserInfoProvider>(context, listen: false).updateImage(image: File(value.path));
    });
  }




  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    taxisController = TextEditingController();
    darayebController = TextEditingController();
  }


  @override
  void dispose() {
    nameController?.dispose();
    taxisController?.dispose();
    darayebController?.dispose();
    super.dispose();
  }
}


// class RegisterInfoController extends GetxController{
//   File? _image;
//   String? _img64;
//   Uint8List? _bytes2;
//   String? _photoView;
//
//   File? get image => _image;
//   String? get img64 => _img64;
//   Uint8List? get bytes2 => _bytes2;
//   String? get photoView => _photoView;
//
//   Future getImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       final imageTemporary = File(image.path);
//       _image = imageTemporary;
//       update();
//       final bytes = File(image.path).readAsBytesSync();
//       _img64 = base64Encode(bytes);
//       update();
//       _bytes2 = const Base64Decoder().convert(img64!);
//       update();
//     } on PlatformException catch (e) {
//       print("field picked image $e");
//     }
//   }
//
//   RequestStatus status= RequestStatus.initial;
//   TextEditingController? nameController;
//   TextEditingController? taxisController;
//   TextEditingController? darayebController;
//   final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
//   SetInfoRepository _setInfoRepository = SetInfoRepository();
//   RegisterLocationController registerLocationController = Get.put(RegisterLocationController());
//   void submit() async{
//     if(globalKey.currentState!.validate()){
//       globalKey.currentState!.save();
//       setLoading();
//       status = RequestStatus.loading;
//       print('my phone is ${nameController!.value.text}');
//       print('my phone is ${taxisController!.value.text}');
//       print('my phone is ${darayebController!.value.text}');
//       var response = await _setInfoRepository.setInfo(
//          taxis: taxisController!.text,
//         darayeb: darayebController!.text,
//         personalName: nameController!.text
//       );
//       Get.back();
//       if (response.statusCode == 200 && response.data["status"] == true) {
//         print("request operation success");
//         if(response.data['data']!=null){
//           Get.offAll(()=>MapScreen(
//             onSave: (lat, lon, address) {
//               registerLocationController.submit(lat: lat,lon: lon,address: address);
//             },
//           ));
//         }
//         print("convert operation success");
//         status = RequestStatus.done;
//         update();
//       }else{
//         status = RequestStatus.done;
//         update();
//         // snackBarDefault(title: response.data['message']??' ',errorMessage: true);
//         customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
//       }
//     }
//   }
//
//   // void onForgetPassword(){
//   //   Get.to(()=>CheckPhoneScreen());
//   // }
//   //
//   // void moveToRegister(){
//   //   // Get.back();
//   //   Get.to(()=>RegisterScreen());
//   // }
//
//   @override
//   void onInit() {
//     super.onInit();
//     nameController = TextEditingController();
//     taxisController = TextEditingController();
//     darayebController = TextEditingController();
//   }
//
//
//   @override
//   void dispose() {
//     nameController?.dispose();
//     taxisController?.dispose();
//     darayebController?.dispose();
//     super.dispose();
//   }
//
//
// }