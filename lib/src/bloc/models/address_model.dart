
class Address {
  Address({
    required this.id,
    required this.address,
    required this.cityId,
    required this.areaId,
    required this.lat,
    required this.lng,
    required this.active,
  });
  late final int id;
  late final String address;
  late final int cityId;
  late final int areaId;
  late final String lat;
  late final String lng;
  late final int active;

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'];
    address = json['address'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    lat = json['lat'];
    lng = json['lng'];
    active = json['active'];
  }

}