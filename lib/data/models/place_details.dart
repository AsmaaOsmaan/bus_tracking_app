class PlaceDetails{
  late Result result;

  PlaceDetails.fromjson(dynamic json){
    result=Result.fromjson(json['result']);
}}



class Result {

  late Geometry geometry;

  Result.fromjson(dynamic json){
    geometry=Geometry.fromjson(json['geometry']);

  }
}


class Geometry {

  late Location location;

  Geometry.fromjson(dynamic json){
    location=Location.fromjson(json['location']);

  }
}
class Location {

  late double lat;
  late double lng;
  Location.fromjson(dynamic json){
    lat=json['lat'];
    lng=json['lng'];

  }
}