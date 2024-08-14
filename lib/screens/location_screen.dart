import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'package:permission_handler/permission_handler.dart';
import 'city_screen.dart';


// Function to request location permission
Future<void> requestLocationPermission() async {
  var status = await Permission.location.request();
  if (status.isDenied) {
    // Permissions are denied, next steps can be decided here
    print("User denied permissions to access the device's location.");
  }
}


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, @required this.weatherData});
  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String? wIcon;
  String? city;
  double? temp;
  String? msg;

  @override
  void initState() {
    super.initState();
    if(widget.weatherData != null);
    requestLocationPermission();
  }


  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      if (widget.weatherData != null) {
        weatherInfo(widget.weatherData);
      } else {
        print('No weather data provided.');
      }
    } else if (status.isDenied) {
      print("User denied permissions to access the device's location.");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }


  void weatherInfo(dynamic wData){
    if (wData != null){
    setState((){
      int weatherId = wData['weather'][0]['id'];
      wIcon = weatherModel.getWeatherIcon(weatherId);
      city = wData['name'];
      double temp1 = wData['main']['temp'];
      temp = temp1.roundToDouble();
      msg = weatherModel.getMessage(temp!.toInt());
    });
    } else {
      city = "Error";
      temp= 0;
      msg = "Unable to get data";
      wIcon = "404";
      return;
    }
  } 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  TextButton(
                    onPressed: () async {
                      var wet = await weatherModel.getLocationWeather();
                      weatherInfo(wet);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if (cityName != null){
                        var weatherCity = await weatherModel.getCityWeather(cityName);
                        weatherInfo(weatherCity);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children:[
                    Text(
                      '${temp?.round()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$wIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$msg in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


