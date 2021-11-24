//
//
// import 'package:aleena/src/bloc/controllers/phone_verify_controller.dart';
// import 'package:aleena/src/features/AuthFeature/ui/screens/register_info_screen.dart';
// import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// class UserController extends GetxController{
//   GetStorage box = GetStorage();
//    setUserInfo(Map<String,dynamic> map){
//     box.write('alternativeـapi_token',map['token']);
//     if(map['data']['phone_verify']!=1){
//       PhoneVerifyController.verifyPhone(phone: phoneController!.text,onSuccess: ()async{
//         await verifyPhoneController.verifyPhone();
//       });
//     }
//     else if(map['set_info']!=1){
//       Get.offAll(()=>RegisterInfoScreen());
//     }
//     else if(map['set_location']!=1){
//       Get.offAll(()=>MapScreen(
//         onSave: (lat, lon, address) => (){
//           print("my address is $address");
//         },
//       ));
//     } else if(map['active']!=1){
//       print('locked');
//     }
//     else{
//       box.write('name',map['name']??' ');
//       box.write('phone',map['phone']??' ');
//       box.write('email',map['email']??' ');
//       box.write('responsableName',map['responsable_name']??' ');
//       box.write('commericalRegisterNumber',map['commerical_register_number']??' ');
//       box.write('taxRegisterNumber',map['tax_register_number']??' ');
//       box.write('token',map['token']??' ');
//       box.write('deviceType',map['device_type']??' ');
//       box.write('image',map['image']??' ');
//       box.write('phoneVerify',map['phone_verify']??0);
//       box.write('setInfo',map['set_info']??0);
//       box.write('setLocation',map['set_location']??0);
//       box.write('login',1);
//     }
//   }
// }