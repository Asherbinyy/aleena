import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/update_personal_info_repo.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:get/get.dart';

class UpdatePersonalInformation extends GetxController {
  RequestStatus status = RequestStatus.initial;
  UpdatePersonalRepository _updatePersonalRepository =
      UpdatePersonalRepository();

  void updatePersonalInfo({
    required String name,
    // required String address,
    // required String lat,
    // required String lng,
    // required int cityId,
    // required int areaId,
  }) async {
    setLoading();
    status = RequestStatus.loading;
    var response = await _updatePersonalRepository.updatePersonalInfo(
        name: name,
        // address: address,
        // lat: lat,
        // lng: lng,
        // cityId: cityId,
        // areaId: areaId,
    );
    Get.back();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");
      Get.offAll(() => HomeScreen());
      print("convert operation success");
      status = RequestStatus.done;
      update();
      customSnackBar(
          title: "Done_".tr, subtitle: 'update_personal_profile_info_down'.tr);
    } else {
      status = RequestStatus.done;
      update();
      customSnackBar(
          title: "Error_".tr, subtitle: response.data['message'] ?? ' ');
    }
  }
}
