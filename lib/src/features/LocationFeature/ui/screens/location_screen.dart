import 'dart:async';
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/controller/map_search_controller.dart';
import 'package:aleena/src/features/LocationFeature/ui/bloc/model/location_model.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/ui/widgets/TextFields/text_field_default.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bar_back.dart';
import 'package:aleena/src/ui/widgets/appbars/app_bars.dart';
import 'package:aleena/src/ui/widgets/buttons/button_default.dart';
import 'package:aleena/src/ui/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/src/core/utils/extensions.dart';


class MapScreen extends StatefulWidget {
  final Function(double,double,String,int?)? onSave;
  final LatLng? targetPosition;
  final Set<Polyline>? polyLines;
  MapScreen({this.onSave,this.targetPosition,this.polyLines});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static LatLng? targetPosition = LatLng(31.037933,31.381523);
  TextEditingController? _locationController;
  Set<Marker> _markers = {};
  BitmapDescriptor? mapMarker;
  bool isMove = false;
  bool isLoading = true;

  GoogleMapController? _controller;

  String? address=' ';
  void setAddress()async{
    setState(() {
      isLoading = true;
    });
    await placemarkFromCoordinates(targetPosition!.latitude, targetPosition!.longitude,localeIdentifier: "ar").then((value) {
      setState(() {
        var data = value.first;
        //  address = data.administrativeArea + data.locality + data.street;
        //  address = "${data.administrativeArea} - ${data.locality} - ${data.street} - ${data.name}";
        address = "${data.administrativeArea} - ${data.locality} - ${data.street}";
      });
      isLoading = false;
    });
  }

  void setCustomMarker()async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/icons/map.png");
  }

  // Set<Circle> circles = Set.from([Circle(
  //   circleId: CircleId(id),
  //   center: LatLng(latitude, longitude),
  //   radius: 4000,
  // )]);

  // void _onMapCreated(GoogleMapController controller){
  //   if(targetPosition!=null){
  //     controller.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: targetPosition!,
  //           bearing: 90.0,
  //           tilt: 45.0,
  //           zoom: 14.4746,
  //         )
  //     ));
  //   }
  //
  //
  //   setState(() {
  //     _markers.add(
  //         Marker(
  //           markerId: MarkerId("my location"),
  //           position: targetPosition!,
  //           // icon: mapMarker!,
  //         )
  //     );
  //   });
  //
  // }

  static  CameraPosition _kGooglePlex = CameraPosition(
      target: targetPosition!,
      zoom: 14.4746,
      bearing: 2.0
  );


  void getMyLocation()async{
    await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        targetPosition = LatLng(value.latitude, value.longitude);
      });
    }).then((value) => setAddress());
  }




  GetStorage box= GetStorage();
  bool search = false;
  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _locationController!.addListener(() {
      if(_locationController!.text.isNotEmpty){
        setState(() {
          search = true;
        });
      }else{
        setState(() {
          search = false;
        });
      }
    });
    if(widget.targetPosition!=null){
      targetPosition = widget.targetPosition;
    }else{
      getMyLocation();
    }
    setAddress();
    // moveCamera();
    // setState(() {
    //   if(widget.targetPosition==null){
    //     getMyLocation();
    //   }
    //   targetPosition = widget.targetPosition;
    // });
    // getMyLocation();
    // setAddress();
    // setCustomMarker();
  }
  Completer<GoogleMapController> _mapController = Completer();




  int areaId = 0;

  void locationInsideArea({required double lat ,required double lon}){

    widget.polyLines!.forEach((element) {
      if(checkIfValidMarker(LatLng(lat,lon),element.points)){
        setState(() {
          areaId = int.tryParse(element.polylineId.toString())!;
        });
      }
    });
  }
  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }
    return true;
  }
  bool checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }
    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }



  @override
  Widget build(BuildContext context) {
    Get.put(MapSearchController());
    return GetBuilder<MapSearchController>(
      builder: (_) =>  Scaffold(
          body: ScaffoldBackground(
            // needAppBar: true,
            appBar: AppBarBack(
              title: "add_client_address".tr,
            ),
            child:  Column(
              children: [
                TextField(
                  controller: _locationController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Search by City',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    if(_locationController!.text.isNotEmpty){
                      _.fetchHome(place: value);
                    }else{
                      _.fetchHome(place: '');
                    }
                  },
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        buildingsEnabled: false,
                        // padding: EdgeInsets.only(top: 300.h),
                        rotateGesturesEnabled: true,
                        mapType: MapType.normal,
                        scrollGesturesEnabled: true,
                        polylines: widget.polyLines?? {},
                        // zoomGesturesEnabled: true,
                        // zoomControlsEnabled: true,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: mapCreated,
                        markers: _markers,
                        onTap: (LatLng pos){
                          setState(() {
                            targetPosition = pos;
                            _markers.clear();
                            _markers.add(
                                Marker(
                                  markerId: MarkerId("my location"),
                                  position: targetPosition!,
                                  // icon: mapMarker!,
                                  // icon: mapMarker!,
                                )
                            );
                         //   locationInsideArea(lat: targetPosition!.latitude,lon: targetPosition!.longitude);
                          });
                          setAddress();
                        },
                      ),
                      search?
                          0.0.ESH():
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 150.h,
                              width: 343.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(19.r),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          text: 'delivery_to'.tr,
                                          color: KCMainBlack,
                                          fontW: FW.regular,
                                          fontSize: 12.8,
                                        ),
                                      ],
                                    ),
                                    5.0.ESH(),
                                    Container(
                                      width: 320.w,
                                      child: CustomText(
                                        text:isLoading?'....':address,
                                        // text:'ahmedfathydfsgjfslklgkjdfjgdkjlfjklf.kgjkldfjgkdfjlglkjlkjfdlkj ',
                                        color: KCMainBlack,
                                        fontW: FW.bold,
                                        fontSize: 16,
                                        overflow: true,
                                      ),
                                    ),
                                    5.0.ESH(),
                                    ButtonDefault(
                                      active: targetPosition!=null,
                                      title: "save_".tr,onTap: (){
                                        print('targetPosition!.latitude ${targetPosition!.latitude}');
                                        print('targetPosition!.longitude ${targetPosition!.longitude}');
                                        print('address! ${address!}');
                                      if(widget.onSave!=null){
                                        print('this is my location');
                                        widget.onSave!(targetPosition!.latitude,targetPosition!.longitude,address!,areaId);
                                      }
                                    },),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      search?
                      ListView.separated(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              _.fetchPlaceCoordinate(placeId: _.places[index].placeId!,onSuccess: (LocationModel value){
                                _locationController!.clear();
                                // _goToPlace(LatLng(value.lat!, value.lng!));
                                // setAddress();
                                setState(() {
                                  targetPosition = LatLng(value.lat!, value.lng!);
                                });
                                moveCamera();
                                setState(() {
                                  _markers.clear();
                                  _markers.add(
                                      Marker(
                                        markerId: MarkerId("my location"),
                                        position: targetPosition!,
                                      )
                                  );
                                });
                                setAddress();

                              });
                            },
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.w
                                ),
                                child: CustomText(
                                  text: _.places[index].description,
                                  color:  KCMain,
                                  fontW: FW.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => 10.0.ESH(),
                          itemCount: _.places.length,
                          shrinkWrap: true,
                      )
                          :
                      0.0.ESH()
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            targetPosition!.latitude,
            targetPosition!.longitude
          ),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }


}
