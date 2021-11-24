import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/ConfirmAddressButtonSheet/confirm_address_button_sheet.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/update_address_repo.dart';
import 'package:aleena/src/features/DrawerFeature/bloc/repository/update_personal_info_repo.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/GeneralSettingScreens/UpdateShopAddressScreen/components/update_confirm_address_button_sheet.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:get/get.dart';

class UpdateAddressController extends GetxController {
  RequestStatus status = RequestStatus.initial;
  UpdateAddressRepository _updateAddressRepository =
  UpdateAddressRepository();
  void updateAddress({
    required String address,
    required double lat,
    required double lon,
  }) async {
    setLoading();
    status = RequestStatus.loading;
    var response = await _updateAddressRepository.updateAddressInfo(
      address: address,
      lat: lat,
      lon: lon,
    );
    Get.back();
    if (response.statusCode == 200 && response.data["status"] == true) {
      print("request operation success");

      Get.dialog(UpdateShopAddressButtonSheet());

      // Get.offAll(() => LoginScreen());


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
