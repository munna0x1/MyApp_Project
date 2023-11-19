import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherPage());
}

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _locationController = TextEditingController();
  String _weatherInfo = '';
  String _backgroundImage = 'assets/icons/sky.png'; // Default background

  final String apiKey = '1b984d6e0224bf393f8cd40457ec1464'; // Replace with your OpenWeatherMap API key

  Future<void> _getWeather() async {
    final String location = _locationController.text;
    final String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey';

    final http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String description = data['weather'][0]['description'];
      final double temperature = data['main']['temp'];
      final String cityName = data['name'];

      setState(() {
        _weatherInfo =
            '$cityName\nTemperature: ${temperature.toString()}°C\nDescription: $description';

        _setBackgroundImage(description.toLowerCase());
      });
    } else {
      setState(() {
        _weatherInfo = 'Failed to get weather information';
      });
    }
  }

  void _setBackgroundImage(String weatherDescription) {
    // Map weather descriptions to background images
    Map<String, String> backgroundMap = {
      'sky': 'assets/icons/sky.png',
      'few clouds': 'assets/few_clouds.jpg',
      'scattered clouds': 'assets/scattered_clouds.jpg',
      'broken clouds': 'assets/broken_clouds.jpg',
      'shower rain': 'assets/shower_rain.jpg',
      'rain': 'assets/rain.jpg',
      'thunderstorm': 'assets/thunderstorm.jpg',
      'snow': 'assets/snow.jpg',
      'mist': 'assets/mist.jpg',
    };

    _backgroundImage = backgroundMap[weatherDescription] ?? _backgroundImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Enter Location',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getWeather,
                child: Text('Get Weather'),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  _weatherInfo,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
