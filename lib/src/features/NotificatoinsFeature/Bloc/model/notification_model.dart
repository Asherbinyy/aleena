
import 'package:aleena/src/bloc/models/order.dart';

class NotificationsModel {
  NotificationsModel({
    required this.id,
    required this.type,
    required this.msg,
    required this.date,
    required this.time,
    required this.deliveryImage,
    required this.deliveryName,
    required this.order,
    this.status,
  });
  late final int id;
  late final String type;
  late final String msg;
  late final String date;
  late final String time;
  late final String deliveryImage;
  late final String deliveryName;
  late final Order order;
  late final int? status;

  NotificationsModel.fromJson(Map<String, dynamic> json){
    id = json['id']??"";
    type = json['type']??"";
    msg = json['msg']??"";
    date = json['date']??"";
    time = json['time']??"";
    deliveryImage = json['deliveryImage']??"";
    deliveryName = json['deliveryName']??"";
    order = Order.fromJson(json['order']);
    status = null;
  }

}

