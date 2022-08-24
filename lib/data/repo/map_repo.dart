import 'package:bus_tracking_app/data/models/place_details.dart';
import 'package:bus_tracking_app/data/models/place_dirictions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_suggestions.dart';
import '../webservcies/placeswebservices.dart';

class PlaceRepository{
  final PlacesWebServices placesWebServices;

  PlaceRepository(this.placesWebServices);
 Future <List<dynamic>>fetchSuggestions(String place,String sessiontoken)async{
   final suggestions=await placesWebServices.getSuggestion(place, sessiontoken);
   return suggestions.map((suggestion) =>PlaceSuggestion.fromJson(suggestion) ).toList();

  }





  Future <PlaceDetails>getPlaceLocation(String placeId,String sessiontoken)async{
    final placeDetails=await placesWebServices.getPlaceLocation(placeId, sessiontoken);
    var readyPlace=PlaceDetails.fromjson(placeDetails);
    return readyPlace;
  }





  Future <PlaceDirections> getDirections(LatLng origin,LatLng destination)async{
    final direction=await placesWebServices.getDirections(origin, destination);
    var readyDirection=PlaceDirections.fromJson(direction);
    return readyDirection;
  }
}