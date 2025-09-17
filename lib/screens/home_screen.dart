import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/crop.dart';
import '../services/crop_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<DocumentSnapshot> _sensorDataStream;
  String _weatherForecast = 'Loading...';
  late List<Crop> _crops;
  Crop? _selectedCrop;

  @override
  void initState() {
    super.initState();
    _sensorDataStream = FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('latest')
        .snapshots();
    _fetchWeatherForecast();
    _crops = CropService.getCrops();
    if (_crops.isNotEmpty) {
      _selectedCrop = _crops.first;
    }
  }

  Future<void> _fetchWeatherForecast() async {
    // 1. Go to https://www.weatherapi.com/ to get a free API key.
    // 2. Replace 'YOUR_API_KEY' with the key you get from the website.
    final apiKey = '7939e11061f2426bb66133641251709';

    if (apiKey == '7939e11061f2426bb66133641251709') {
      if (mounted) {
        setState(() {
          _weatherForecast = 'Please add a valid WeatherAPI.com API key.';
        });
      }
      return;
    }

    // Using the same coordinates as the previous placeholder (latitude,longitude)
    const location = '33.74,-84.39';
    final url = 'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

    try {
      final response = await http.get(Uri.parse(url));
      if (mounted) {
        if (response.statusCode == 200) {
          final weatherData = json.decode(response.body);
          final description = weatherData['current']['condition']['text'];
          final temperature = weatherData['current']['temp_c'];
          setState(() {
            _weatherForecast = '$description ($temperature°C)';
          });
        } else {
          setState(() {
            _weatherForecast = 'Failed to load weather data.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _weatherForecast = 'Error fetching weather data.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Sensor Data'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _sensorDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No sensor data available.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          }

          final data = snapshot.data!.data();

          if (data == null || data is! Map<String, dynamic>) {
            return const Center(child: Text('Invalid data format from Firestore.'));
          }
          
          final soilMoisture = data['soil_moisture'];
          final temperature = data['temperature'];
          final humidity = data['humidity'];
          final waterTankLevel = data['water_tank_level'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCropDropdown(),
                  const SizedBox(height: 16.0),
                  _buildSensorCard('Soil Moisture', '${soilMoisture ?? 'N/A'}%'),
                  _buildSensorCard('Temperature', '${temperature ?? 'N/A'}°C'),
                  _buildSensorCard('Humidity', '${humidity ?? 'N/A'}%'),
                  _buildSensorCard('Water Tank Level', '${waterTankLevel ?? 'N/A'}%'),
                  const SizedBox(height: 16.0),
                  _buildStatusCard(soilMoisture, _selectedCrop),
                  const SizedBox(height: 16.0),
                  _buildWeatherCard(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCropDropdown() {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Crop>(
            isExpanded: true,
            value: _selectedCrop,
            items: _crops.map((Crop crop) {
              return DropdownMenuItem<Crop>(
                value: crop,
                child: Text(crop.name, style: const TextStyle(fontSize: 18.0)),
              );
            }).toList(),
            onChanged: (Crop? newCrop) {
              if (newCrop != null) {
                setState(() {
                  _selectedCrop = newCrop;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, String value) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18.0)),
            Text(value, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(dynamic soilMoisture, Crop? selectedCrop) {
    String status;
    Color statusColor;

    int moistureValue = 0;
    if (soilMoisture is num) {
      moistureValue = soilMoisture.toInt();
    } else if (soilMoisture is String) {
      moistureValue = int.tryParse(soilMoisture) ?? 0;
    }

    if (selectedCrop != null) {
      if (moistureValue < selectedCrop.minMoisture) {
        status = 'Soil is dry for ${selectedCrop.name} – irrigation required';
        statusColor = Colors.red;
      } else if (moistureValue > selectedCrop.maxMoisture) {
        status = 'Soil is wet for ${selectedCrop.name} – no irrigation needed';
        statusColor = Colors.blue;
      } else {
        status = 'Soil moisture is optimal for ${selectedCrop.name}';
        statusColor = Colors.green;
      }
    } else {
      status = 'Select a crop to see irrigation advice';
      statusColor = Colors.grey;
    }

    return Card(
      elevation: 2.0,
      color: statusColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            status,
            style: const TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weather Forecast', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(_weatherForecast, style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
