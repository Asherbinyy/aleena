
import 'package:aleena/src/features/LocationFeature/ui/bloc/model/location_model.dart';

class Geometry {
  final LocationModel? location;

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic,dynamic> parsedJson)
      :location = LocationModel.fromJson(parsedJson['location']);
}


