import 'dart:async';
import 'dart:io';

import 'package:bus_tracking_app/business_logic/cubit/places/place_cubit.dart';
import 'package:bus_tracking_app/business_logic/cubit/places/places_state.dart';
import 'package:bus_tracking_app/data/models/place_details.dart';
import 'package:bus_tracking_app/data/models/place_dirictions.dart';
import 'package:bus_tracking_app/data/models/place_suggestions.dart';
import 'package:bus_tracking_app/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';



class MapScreen extends StatefulWidget {
  final PlaceSuggestion? placeSuggestion;

  const MapScreen({Key? key, this.placeSuggestion}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker>markers=Set();
  late PlaceDetails selectedPlace;
  late CameraPosition goToSearchPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
late  Position currentPostion;

// this variables for getDirections
  PlaceDirections? placeDirections;
  var progressIndicator=false;
  late List<LatLng> polyLinesPoint;
  late String time;
  late String distance;
  bool loaded=false;

// to track
  StreamSubscription<Position>? positionStream;
 BitmapDescriptor? customMarker;


 getCustomMarker()async{
   customMarker=await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/images/beachflag2.png');
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedPlaceLocation();
    buildCurrentLocationMarker();
    Geolocator.getPositionStream().listen(
            (Position? position) {
              print("getPositionStream${position!.latitude}");
              print(position.longitude);

              trackBus(position.latitude,position.longitude);
        });
    getCustomMarker();

  }
  
  void trackBus(newLat,newLng){
    markers.remove(Marker(markerId: MarkerId('1')));
    markers.add(Marker(markerId: MarkerId("1"),position: LatLng(newLat,newLng),icon: customMarker!));
    setState(() {

    });
    
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:BlocListener<PlacesCubit,PlacesState>(listener:(context, state) {
        if (state is PlaceLocationLoading){

        }
        if(state is PlaceLocationLoaded) {
          selectedPlace = (state).placeDetails;
          goToMySearchedForLocation();

        getDirections();}
        if(state is DirectionLoaded) {
          placeDirections = (state).placeDirections;
          getPolyLinePoints();
        }else{}




      },
        child:loaded==true? Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              markers: markers,
              initialCameraPosition:getIntialCameraPostion (),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: placeDirections!=null?{
                Polyline(
                    polylineId: const PolylineId('polyLine'),
                  color: Colors.red,
                  width: 6,
                  points: polyLinesPoint,


                )
              }:{
              }
            ),
            Positioned(
              bottom: 0,
                right: 1,
                left: 1,
                child: BottomSheetWidget(placeDirections: placeDirections,))

          ],
        ):Center(child: CircularProgressIndicator(),)
      ),

    );
  }




  void buildCameraNewPosition(){
    goToSearchPlace=CameraPosition(
        bearing: 0.0,
        target: LatLng(
          selectedPlace.result.geometry.location.lat,
          selectedPlace.result.geometry.location.lng,

        )
    );
  }

  void getSelectedPlaceLocation(){
    final sesstionToken=Uuid().v4() ;

    BlocProvider.of<PlacesCubit>(context).emitPlaceLocation(widget.placeSuggestion!.placeId, sesstionToken);
  }





  Future<void> goToMySearchedForLocation()async{
    buildCameraNewPosition();
    //final GoogleMapController controller=await _controller.future;
  //  controller.animateCamera(CameraUpdate.newCameraPosition(goToSearchPlace));
    buildSearchedPlaceMarker();
    print("endgoToMySearchedForLocation");

  }


  void buildSearchedPlaceMarker(){
    searchedPlaceMarker=Marker(
      position: goToSearchPlace.target,
      markerId: MarkerId('2'),
    );

    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }
  /// get current LocationFromBloc
  void buildCurrentLocationMarker()async{
  await  BlocProvider.of<PlacesCubit>(context).detectCurrentLocationfuture();
    Position position =  BlocProvider.of<PlacesCubit>(context).currentPosition;
    currentLocationMarker=Marker(
      position: LatLng(position.latitude,position.longitude),
      markerId: MarkerId('1'),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);

  }

  void addMarkerToMarkersAndUpdateUI(Marker marker){
    setState(() {
      markers.add(marker);
    });
  }
  CameraPosition getIntialCameraPostion(){
    return
        CameraPosition(
      target: LatLng(BlocProvider.of<PlacesCubit>(context).currentPosition.latitude, BlocProvider.of<PlacesCubit>(context).currentPosition.longitude),
      zoom: 10,
    );


  }





// with map
  void buildDirectionBloc(){
     BlocListener<PlacesCubit,PlacesState>(listener:(context, state) {
      if(state is DirectionLoaded)
        placeDirections=(state).placeDirections;
      getPolyLinePoints();

    },
    child: Container(),);
  }
  void getPolyLinePoints(){

  //  print("getPolyLines");
    polyLinesPoint=placeDirections!.polyLinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList();
    setState(() {
      loaded=true;
    });
   //print("polyLinesPointList:${polyLinesPoint}");
  }
  //TODO call getdirictions before getPolyLine
  void getDirections(){
  //  setCurrentLocation();
BlocProvider.of<PlacesCubit>(context).emitPlaceDirection(LatLng(BlocProvider.of<PlacesCubit>(context).currentPosition.latitude,BlocProvider.of<PlacesCubit>(context).currentPosition.longitude), LatLng(selectedPlace.result.geometry.location.lat,selectedPlace.result.geometry.location.lng));
  }
  // void TestPolyLines(){
  //   getDirections();
  //   BlocListener<PlacesCubit,PlacesState>(listener:(context, state) {
  //     if(state is DirectionLoaded)
  //       placeDirections=(state).placeDirections;
  //     getPolyLinePoints();
  //
  //   },
  //     child: Container(),);
  //
  // }

}

