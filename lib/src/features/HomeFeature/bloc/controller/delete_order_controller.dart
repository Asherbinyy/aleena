

import 'package:aleena/src/core/services/dialogs.dart';
import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/HomeFeature/bloc/controller/home_controller.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/add_order_repository.dart';
import 'package:aleena/src/features/HomeFeature/bloc/repo/delete_order_repo.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


class DeleteOrderController extends GetxController{
  RequestStatus status= RequestStatus.initial;
  HomeController _homeController = Get.put(HomeController());
      DeleteOrderRepository _deleteOrderRepository = DeleteOrderRepository();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  void deleteOrder( {required int orderId }) async{
    int indexOrder = _homeController.waitingOrders.indexWhere((element) => element.id==orderId);
    print("indexOrder in controller $indexOrder");
        status = RequestStatus.loading;
        setLoading();
        var response = await _deleteOrderRepository.deleteOrder(orderId: orderId );
        Get.back();
        if (response.statusCode == 200 && response.data["status"] == true) {
          print("request operation success");
          if(indexOrder !=null){
            _homeController.deleteOrder(indexOrder);
            update();
            print("delete order in list local");
          }
          customSnackBar(title: "Done_".tr,subtitle:  response.data['message']??' ');
          print("convert operation success");
          status = RequestStatus.done;
          update();
        }else{
          status = RequestStatus.done;
          update();
          customSnackBar(title: "Error_".tr,subtitle:  response.data['message']??' ');
        }

  }
}