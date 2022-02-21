import 'package:aleena/src/core/utils/request_status.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/model/location_model.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/model/place.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/model/place_search.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/repository/fetch_place_coordinates_repository.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/repository/fetch_place_repository.dart';
import 'package:get/get.dart';



class MapSearchController extends GetxController{
  List<PlaceSearch> places = [];
  FetchPlaceRepository fetchPlaceRepository = FetchPlaceRepository();
  RequestStatus status= RequestStatus.initial;
  Future<void> fetchHome({String place = ''})async{
    status = RequestStatus.loading;
    update();
    var response = await fetchPlaceRepository.fetchPlace(place: place);
    if (response.statusCode == 200 && response.data["status"] == 'OK') {
      print("request operation success");
      places.clear();
      for (var item in response.data['predictions']) {
        places.add(PlaceSearch.fromJson(item));
      }
      print("convert operation success");
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.error;
      update();
    }
  }



  FetchPlaceCoordinatesRepository fetchPlaceCoordinatesRepository = FetchPlaceCoordinatesRepository();
  Future<void> fetchPlaceCoordinate({String placeId = '',Function(LocationModel)? onSuccess})async{
    status = RequestStatus.loading;
    update();
    var response = await fetchPlaceCoordinatesRepository.fetchPlaceCoordinates(placeId: placeId);
    if (response.statusCode == 200 && response.data["status"] == 'OK') {
      print("request operation success");
      places.clear();
      print('lllllllllllllllllllllllll ${response.data['result']['geometry']['location']['lat']}');
      LocationModel locationModel = LocationModel.fromJson(response.data['result']['geometry']['location']);
      print("convert operation success");
      onSuccess!(locationModel);
      status = RequestStatus.done;
      update();
    }else{
      status = RequestStatus.error;
      update();
    }
  }
}