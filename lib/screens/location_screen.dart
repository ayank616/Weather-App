// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? city, weatherIcon, weatherMess, sunrise, sunset, wc1, wc2;
  int? temp;
  double? mintemp, maxtemp;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locsationWeather);
  }

  void updateUi(var weatherdata) {
    setState(() {
      if (weatherdata == null) {
        weatherIcon = "Error";
        temp = 0;
        mintemp = maxtemp = 0;
        weatherMess = "Unable to get the weather";
        city = "No city";
        sunrise = sunset = "00:00 AM/PM";
        wc1 = wc2 = "Unable to get the weather";
        return;
      }
      int condition = weatherdata['weather'][0]["id"];
      weatherIcon = weather.getWeatherIcon(condition);
      wc1 = weatherdata["weather"][0]["main"];
      wc2 = weatherdata["weather"][0]["description"];
      double temperature = weatherdata['main']['temp'];
      mintemp = weatherdata['main']['temp_min'];
      maxtemp = weatherdata['main']['temp_max'];
      temp = temperature.toInt();
      weatherMess = weather.getMessage(temp!);
      city = weatherdata['name'];
      //SunSet & SunRise
      int sunRise = weatherdata['sys']['sunrise'];
      int sunSet = weatherdata['sys']['sunset'];
      DateTime Rise = DateTime.fromMillisecondsSinceEpoch(sunRise * 1000);
      DateTime Set = DateTime.fromMillisecondsSinceEpoch(sunSet * 1000);
      sunrise = DateFormat('hh:mm a').format(Rise);
      sunset = DateFormat('hh:mm a').format(Set);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0e1c26),
                Color(0xFF2a454b),
                Color(0xFF0e1c26),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather.getLocationWeather();
                      updateUi(weatherdata);
                    },
                    child: const Icon(
                      Icons.location_pin,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (cityName != null) {
                        var weatherData =
                            await weather.getCityWeather(cityName);
                        updateUi(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.search,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Text('$city', style: kMessageTextStyle),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Main Temp
                    Container(
                      height: 140,
                      margin: const EdgeInsets.only(right: 15, left: 10),
                      child: Center(
                          child: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: '$temp°', style: kTempTextStyle1),
                          const TextSpan(text: 'C', style: kTempTextStyle1_2)
                        ]),
                      )),
                    ),
                    Container(
                      height: 140,
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(text: 'Max : \n'),
                              TextSpan(
                                  text: '$maxtemp°', style: kTempTextStyle2),
                              const TextSpan(
                                  text: 'C', style: kTempTextStyle2_2)
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(text: 'Min : \n'),
                              TextSpan(
                                  text: '$mintemp°', style: kTempTextStyle2),
                              const TextSpan(
                                  text: 'C', style: kTempTextStyle2_2)
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.transparent.withOpacity(0.0001),
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(text: '$weatherIcon    ', style: kTab1_1),
                        TextSpan(text: '$wc1   :   ', style: kTab1_2),
                        TextSpan(text: '$wc2', style: kTab1_3),
                      ])),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.transparent.withOpacity(0.0001),
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "$weatherMess in $city.",
                        textAlign: TextAlign.center,
                        style: kTab2,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Card(
                    color: Colors.transparent.withOpacity(0.0001),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text('Sunrise :', style: khead)),
                              Expanded(
                                flex: 5,
                                child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset("images/sunrise.png")),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text('$sunrise', style: ktime)),
                            ],
                          ),
                          const VerticalDivider(
                            width: 0,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text('Sunset :', style: khead)),
                              Expanded(
                                flex: 5,
                                child: CircleAvatar(
                                    radius: 35,
                                    child: Image.asset("images/sunset.png")),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text('$sunset', style: ktime)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
