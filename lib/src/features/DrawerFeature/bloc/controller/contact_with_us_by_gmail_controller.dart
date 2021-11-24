

import 'package:aleena/src/bloc/controllers/phone_verify_controller.dart';
import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/set_location_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verfication_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/controller/verify_phone_controller.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/login_repository.dart';
import 'package:aleena/src/features/AuthFeature/bloc/repo/register_location_controller.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/phone_input_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_info_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/contact_with_us_by_gmail_repo.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/features/LocationFeature/ui/screens/location_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ContactWithUsByGmailController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  TextEditingController? gmailController;
  TextEditingController? messageController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ContactWithUsByGmailRepository _contactWithUsByGmailRepository = ContactWithUsByGmailRepository();
  void submit() async{
    if(globalKey.currentState!.validate()){
      globalKey.currentState!.save();
      setLoading();
      status = RequestStatus.loading;
      var response = await _contactWithUsByGmailRepository.contactWithUsByGmail(gmail: gmailController!.text,message: messageController!.text);
      Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        print("convert operation success");
        status = RequestStatus.done;
        Get.offAll(()=> HomeScreen());
        messageController!.text="";
        gmailController!.text="";
        update();
        customSnackBar(title: "Done_".tr,subtitle:  'conect_success'.tr);
      }else{
        status = RequestStatus.done;
        update();
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    gmailController = TextEditingController();
    messageController = TextEditingController();
  }


  @override
  void dispose() {
    gmailController?.dispose();
    messageController?.dispose();
    super.dispose();
  }
}