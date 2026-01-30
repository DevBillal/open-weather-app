import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  Future<Map<String, dynamic>> fetchWeatherData() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 3));

    // Simulated weather data
    return {
      'city': 'Chittagong',
      'temperature': 28,
      'condition': 'Sunny',
      'humidity': 75,
      'icon': '☀️',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<Map<String, dynamic>>(
            future: fetchWeatherData(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 5,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Weather data loading...',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '(3 seconds wait)',
                      style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 60),
                    SizedBox(height: 20),
                    Text(
                      'Error',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              }

              if (snapshot.hasData) {
                final weather = snapshot.data!;

                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[300]!, Colors.blue[600]!],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Success icon
                        Icon(Icons.check_circle, color: Colors.white, size: 50),
                        SizedBox(height: 10),
                        Text(
                          'Data loaded successfully!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 30),

                        // Weather icon
                        Text(weather['icon'], style: TextStyle(fontSize: 80)),
                        SizedBox(height: 20),

                        // City name
                        Text(
                          weather['city'],
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        // Temperature
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${weather['temperature']}',
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Weather condition
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            weather['condition'],
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Humidity
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Humidity: ${weather['humidity']}%',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Text('No data available');
            },
          ),
        ),
      ),

      // Refresh button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          (context as Element).markNeedsBuild();
        },
        backgroundColor: Colors.blue,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
