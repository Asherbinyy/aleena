
class NotificationModel {
  NotificationModel({
    required this.title,
    required this.bode,
    required this.dataBody,
    required this.dataTitle,

  });
  late final String title;
  late final String bode;
  late final String dataBody;
  late final String dataTitle;


  NotificationModel.fromJson(Map<String, dynamic> json){
    title = json['id'];
    bode = json['address'];
    dataBody = json['city_id'];
    dataTitle = json['area_id'];
  }

}