

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper{

static  Future<Position>detectCurrentLocation()async{
  bool isServiceEnable=await Geolocator.isLocationServiceEnabled();
LocationPermission? per;
  
 // if(isServiceEnable==false)
    per=await Geolocator.checkPermission();
     print("percheck:${per}");
    if(per==LocationPermission.denied||per==null){
      print("per:${per}");
      await Geolocator.requestPermission();

    }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );

}



static  Future<dynamic> convertPositionToAddress()async{
  List<Placemark> placemarks;
  Position position=await detectCurrentLocation();
  placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

   // var addresses =  Geocoder.local.findAddressesFromCoordinates(value);

return placemarks.first;
}


}