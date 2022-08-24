import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/strings.dart';

class PlacesWebServices{
late Dio dio;
PlacesWebServices(){
  BaseOptions option=BaseOptions(
    connectTimeout: 20*1000,
    receiveTimeout: 20*1000,

  );
  //create new object
  dio =Dio(option);

}

Future<List<dynamic>>getSuggestion(String place,String sessiontoken)async{
  print("start");
  try {
    Response response=await dio.get(suggestionUrl,queryParameters: {
      'input':place,
      'types':'address',
      'components':'country:eg',
      'key':GoogleApiKey,
      'sessiontoken':'sessiontoken',


    }) ;
    print("${place}");

    print(response.statusCode);
    print(response.data['predictions']);
    return response.data['predictions'];

}
catch(error){
    print(error.toString());
return [];
}

}


Future<dynamic>getPlaceLocation(String placeId,String sessiontoken)async{
  print("start");
  try {
    Response response=await dio.get(placeLocationBaseUrl,queryParameters: {
      'place_id':placeId,
      'fields':'geometry',
      'components':'country:eg',
      'key':GoogleApiKey,
      'sessiontoken':'sessiontoken',


    }) ;


    print(response.statusCode);

    return response.data;

  }
  catch(error){

    return Future.error('place location error :',StackTrace.fromString('this is its trace'));
  }

}


Future<dynamic> getDirections(LatLng origin,LatLng destination)async{
  try {
    Response response=await dio.get(directionsBaseUrl,queryParameters: {
      'origin':'${origin.latitude},${origin.longitude}',
      'destination':'${destination.latitude},${destination.longitude}',
      'components':'country:eg',
      'key':GoogleApiKey,

    }) ;


    print("getDirections${response.statusCode}");
    print("getDirections${response.data}");

    return response.data;

  }
  catch(error){

    return Future.error('direction error :',StackTrace.fromString('this is its trace'));
  }

}


}