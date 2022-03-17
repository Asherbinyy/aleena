import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/log_out_repo.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogOutController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  GetStorage box = GetStorage();
  LogOutRepository _logOutRepository = LogOutRepository();
  void logOut() async{
    box.remove('login');
    box.remove('token');
    Get.offAll(LoginScreen());
      // setLoading();
      status = RequestStatus.loading;
      var response = await _logOutRepository.logOut();
      // Get.back();
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("request operation success");
        print("convert operation success");
        status = RequestStatus.done;
        update();
        customSnackBar(title: "Done_".tr,subtitle:  response.data['message']??' ');
      }else{
        status = RequestStatus.done;
        update();
        // snackBarDefault(title: response.data['message']??' ',errorMessage: true);
        customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
      }

  }

}