// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:geolocator/geolocator.dart';

class Location{

  double? lat; 
  double? lgt;

  Future <void> getCurrentLocation() async {
    try{
      
      final LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );

      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      
      lgt = position.longitude;
      lat = position.latitude;

    
    } catch (e){
      print(e);
    }
  }

}