import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Region {
  int? id;
  String? title;
  List<PositionModel>? coordinates;


  Region({this.id, this.coordinates});

  Region.fromJson(Map<String,dynamic> map){
     id = map['id'] ?? 0;
     title = map['title'] ?? ' ';
     setCoordinates(map);
  }

  void setCoordinates(Map<String,dynamic> map){
    coordinates = [];
    if(map['latlng']!=null){
      print('hawam 3am elnas');
      map['latlng'].forEach((v) {
        print('hawam 5awal');
        coordinates!.add(PositionModel.fromJson(v));
      });
    }
    for(var coor in coordinates!){
      print('my result is ${coor.lat}');
      print('my result is ${coor.lon}');
    }
  }
}


class PositionModel {
  double? lat;
  double? lon;
  PositionModel({this.lon,this.lat});


  PositionModel.fromJson(Map<String,dynamic> map){
    print('a6aaaaa ${map['lng']}');
    lat = map['lat']!=null ?double.tryParse(map['lat'].toString()):0.0;
    lon = map['lng']!=null ?double.tryParse(map['lng'].toString()):0.0;
  }




}