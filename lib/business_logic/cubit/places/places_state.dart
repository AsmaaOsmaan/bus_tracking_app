
  import 'package:bus_tracking_app/data/models/place_details.dart';
import 'package:bus_tracking_app/data/models/place_dirictions.dart';
import 'package:bus_tracking_app/data/models/place_suggestions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class PlacesState{

  }
  class PlacesInitial extends PlacesState{

  }
class PlacesLoaded extends PlacesState{
  final List<dynamic>places;

  PlacesLoaded(this.places);

}
  class PlaceLocationLoading extends PlacesState{

  }
class PlaceLocationLoaded extends PlacesState{
  final PlaceDetails placeDetails;
  PlaceLocationLoaded(this.placeDetails);
}
class CurrentLocationLoaded extends PlacesState{
  final Position currentLocation;
  CurrentLocationLoaded(this.currentLocation);
}

  class convertLocationToAddress extends PlacesState{
    final Placemark placemark;
    convertLocationToAddress(this.placemark);
  }
  class DirectionLoaded extends PlacesState{
    final PlaceDirections placeDirections;
    DirectionLoaded(this.placeDirections);
  }

