import 'package:bus_tracking_app/business_logic/cubit/places/places_state.dart';
import 'package:bus_tracking_app/data/repo/map_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helper/location_helper.dart';

class PlacesCubit extends Cubit<PlacesState>{

  Placemark? placemark;

  final PlaceRepository placeRepository;
  late Position currentPosition;


  PlacesCubit(this.placeRepository) : super(PlacesInitial());
  void emitPlaceSuggestions(String place,String sessionToken){
    placeRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
    
  }



  void emitPlaceLocation(String placeId,String sessionToken){
    emit(PlaceLocationLoading());
    placeRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });

  }
  void detectCurrentLocation()async{
    emit(PlaceLocationLoading());

    currentPosition=await LocationHelper.detectCurrentLocation() ;
    emit(CurrentLocationLoaded(currentPosition));
     placemark=await LocationHelper.convertPositionToAddress() ;
    emit(convertLocationToAddress(placemark!));

  }



  void emitPlaceDirection(LatLng origin ,LatLng destination){
    emit(PlaceLocationLoading());
    placeRepository.getDirections(origin ,destination).then((direction) {
      emit(DirectionLoaded(direction));
    });

  }
  Future<void>  detectCurrentLocationfuture()async{
    // emit(LoadingCurrentLocation());

    currentPosition=await LocationHelper.detectCurrentLocation() ;
    print("currentPosition${currentPosition}");
    emit(CurrentLocationLoaded(currentPosition));
    placemark=await LocationHelper.convertPositionToAddress() ;
    emit(convertLocationToAddress(placemark!));

  }
}