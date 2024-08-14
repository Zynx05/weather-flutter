// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState(){
      super.initState();
      getLocationData();
  }

  void getLocationData() async {
    var currentLocationWeather = await weatherModel.getLocationWeather(); 
    
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherData: currentLocationWeather);
    }));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
          )

      ),
    );
  }
}
