import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/update_shop_repo.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'dart:convert';
import 'dart:io';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_location_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/set_info_repository.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';

class SetAvatarController extends GetxController {

  GetStorage box = GetStorage();

  Future<void> updateImage({required File image})async{
    String apiToken = await box.read('token')??box.read('alternativeـapi_token')??' ';
    var uri =
    Uri.parse("https://3leena.com/public/api/shops/updateInfo");
    var request = http.MultipartRequest("POST", uri);
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var multipartFile1 = new http.MultipartFile('image', stream, length, filename: basename(image.path), contentType: new MediaType('image', 'png'));
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
      await box.write("avatarShop", data['data']['image']);
      print("avatarShop>>>>>>>>>:-> ${ data['data']['image']}");
      return ;
    } else if (response.statusCode == 401) {
      return ;
    }
  }

  File? _image ;

  File? get image => _image;
  final picker = ImagePicker();
  Future getImage() async {
    await picker.getImage(source: ImageSource.gallery).then((value) async {
        if (value != null) {
          _image = File(value.path);
          update();
        } else {
          print('No image selected.');
        }
      print("_image in controller $_image");
        updateImage(image: _image!);
      // await Provider.of<UserInfoProvider>(context, listen: false).updateImage(image: File(value.path));
    });
  }

}