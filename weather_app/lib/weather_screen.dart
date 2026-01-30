import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_items.dart';
import 'package:weather_app/hidden.dart';
import 'package:weather_app/hourly_forcast.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  // fetch weather data from api
  Future<Map<String, dynamic>> getCurrentWeather() async {
    //try catch block
    try {
      //city name
      String cityname = 'Feni';
      //api url
      final url = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$openWeatherAPIKey&units=metric',
        ),
      );
      // decode the response
      final data = jsonDecode(url.body);
      // check for errors
      if (data['cod'] != 200) {
        throw 'An error occurre  : ${data['message']}';
      }

      // data fetched successfully
      return data;

      //update the state with fetched data
      // data['main']['temp'];
    }
    // catch and throw errors
    catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather app',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;

          final currTemp = data['main']['temp'];

          final currSky = data['weather'][0]['main'];

          // additional info
          final currHumidity = data['main']['humidity'];
          final currWSpeed = data['wind']['speed'];
          final currPressure = data['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // main result
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),

                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Recent Weater text
                              Text(
                                // print the temp value fetched from api
                                '$currTemp°C',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              // Recent Weater Icon
                              Icon(
                                currSky == 'Clouds' || currSky == 'Rain'
                                    ? Icons.cloud_outlined
                                    : Icons.sunny,

                                size: 70.0,
                              ),
                              SizedBox(height: 10.0),
                              // Recent Weater condition text
                              Text(
                                currSky,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //weather forcast
                Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         HourlyForcastItems(
                //           time: data['dt'].toString(),
                //           icon: currSky == 'Clouds' || currSky == 'Rain'
                //               ? Icons.cloud
                //               : Icons.sunny,
                //           temp: currTemp.toString(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return HourlyForcastItems(
                        time: DateFormat.j().format(
                          DateTime.now().add(Duration(hours: index + 1)),
                        ),
                        icon: currSky == 'Clouds' || currSky == 'Rain'
                            ? Icons.cloud_outlined
                            : Icons.sunny,
                        temp: currTemp.toString(),
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                  ),
                ),
                //additional information
                Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItems(
                      icon: Icons.water_drop,
                      lable: 'Humidity',
                      value: '$currHumidity%',
                    ),
                    AdditionalInfoItems(
                      icon: Icons.air,
                      lable: 'Wind Speed',
                      value: '$currWSpeed km/h',
                    ),
                    AdditionalInfoItems(
                      icon: Icons.beach_access,
                      lable: 'Pressure',
                      value: currPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
