
import 'package:aleena/src/bloc/models/order.dart';

class NotificationsModel {
  NotificationsModel({
     this.id,
     this.type,
     this.msg,
     this.date,
     this.time,
     this.deliveryImage,
     this.deliveryName,
     this.order,
    this.status,
  });
  late final int? id;
  late final String? type;
  late final String? msg;
  late final String? date;
  late final String? time;
  late final String? deliveryImage;
  late final String? deliveryName;
  late final Order? order;
  late final int? status;

  NotificationsModel.fromJson(Map<String, dynamic> json){
    id = json['id']??"";
    type = json['type']??"";
    msg = json['msg']??"";
    date = json['date']??"";
    time = json['time']??"";
    deliveryImage = json['deliveryImage']??"";
    deliveryName = json['deliveryName']??"";

    if(json["order"] ==null ){
      order = Order(
        status: 1,
        deliveryImage: '',
        deliveryName: '',
        duration: '',
        phone: '',
        address: '',
        id: 0,
        price: '',
        clientName: '',
        orderNumber: '',
        paymentMethod: '',
        deliveryPhone: '',
        qrCode: ''
      );
    }else{
      order = Order.fromJson(json['order']);
    }
    if(json['status']==null || json['status']==""){
      status = 0;
    }else{
      status = int.tryParse(json['status'].toString());
    }
  }
}

