import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/update_shop_repo.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';


class UpdateShopInfoController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  UpdateShopRepository _pdateShopRepository = UpdateShopRepository();
  void updatePersonalInfo({required String commercialRegistrationNumber , required String adminName , required String taxAuthorityNumber}) async{
      setLoading();
      status = RequestStatus.loading;
      var response = await _pdateShopRepository.updatePersonalInfo(commercialRegistrationNumber: commercialRegistrationNumber, adminName: adminName, taxAuthorityNumber: taxAuthorityNumber);
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        Get.offAll(()=>HomeScreen());
        print("convert operation success");
        status = RequestStatus.done;
        update();
        customSnackBar(title: "Done_".tr,subtitle: 'update_personal_profile_info_down'.tr);
      }else{
        status = RequestStatus.done;
        update();
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }
  }
  GetStorage box = GetStorage();
  Future<void> updateCommercialRegisterImage({required File image})async{
    String apiToken = await box.read('apiToken')??box.read('alternativeـapi_token')??' ';
    var uri =
    Uri.parse("https://dondorma.crazyideaco.com/public/alayna/public/api/shops/updateInfo");
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
    Uri.parse("https://dondorma.crazyideaco.com/public/alayna/public/api/shops/updateInfo");
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

}