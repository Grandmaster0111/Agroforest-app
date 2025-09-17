import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/crop.dart';
import '../services/crop_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<DocumentSnapshot> _sensorDataStream;
  late Stream<DocumentSnapshot> _controlStream;

  String _weatherForecast = 'Loading...';
  late List<Crop> _crops;
  Crop? _selectedCrop;

  bool _isAutoMode = true;
  bool _isValveOn = false;

  @override
  void initState() {
    super.initState();
    _sensorDataStream = FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('latest')
        .snapshots();
    _controlStream = FirebaseFirestore.instance
        .collection('irrigation_control')
        .doc('settings')
        .snapshots();
    _fetchWeatherForecast();
    _crops = CropService.getCrops();
    if (_crops.isNotEmpty) {
      _selectedCrop = _crops.first;
    }
  }

  Future<void> _fetchWeatherForecast() async {
    final apiKey = '7939e11061f2426bb66133641251709';

    const location = '33.74,-84.39';
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.realTimeSensorData)),
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
                padding: EdgeInsets.all(16.0),
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
            return const Center(
              child: Text('Invalid data format from Firestore.'),
            );
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
                  _buildSensorCard(
                    AppLocalizations.of(context)!.soilMoisture,
                    '${soilMoisture ?? 'N/A'}%',
                    Icons.wb_sunny,
                  ),
                  _buildSensorCard(AppLocalizations.of(context)!.temperature, '${temperature ?? 'N/A'}°C',
                      Icons.thermostat),
                  _buildSensorCard(AppLocalizations.of(context)!.humidity, '${humidity ?? 'N/A'}%',
                      Icons.water_drop),
                  _buildWaterTankCard(waterTankLevel),
                  const SizedBox(height: 16.0),
                  _buildWaterTankStatusCard(waterTankLevel),
                  const SizedBox(height: 16.0),
                  _buildStatusCard(soilMoisture, _selectedCrop),
                  const SizedBox(height: 16.0),
                  _buildWeatherCard(),
                  const SizedBox(height: 16.0),
                  _buildControlCard(),
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

  Widget _buildSensorCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18.0)),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterTankCard(dynamic waterTankLevel) {
    double level = 0.0;
    if (waterTankLevel is num) {
      level = waterTankLevel.toDouble();
    }

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.storage, size: 40, color: Colors.blue),
                const SizedBox(width: 16.0),
                Text(AppLocalizations.of(context)!.waterTankLevel,
                    style: const TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: level / 100,
                    minHeight: 10.0,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${level.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterTankStatusCard(dynamic waterTankLevel) {
    double level = 0.0;
    if (waterTankLevel is num) {
      level = waterTankLevel.toDouble();
    }

    String status;
    Color statusColor;

    if (level < 20) {
      status = AppLocalizations.of(context)!.waterTankLow;
      statusColor = Colors.red;
    } else if (level > 95) {
      status = AppLocalizations.of(context)!.waterTankFull;
      statusColor = Colors.yellow;
    } else {
      status = AppLocalizations.of(context)!.waterTankOptimal;
      statusColor = Colors.green;
    }

    return Card(
      elevation: 2.0,
      color: statusColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            status,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
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
        status = AppLocalizations.of(context)!.soilDry(selectedCrop.name);
        statusColor = Colors.red;
      } else if (moistureValue > selectedCrop.maxMoisture) {
        status = AppLocalizations.of(context)!.soilWet(selectedCrop.name);
        statusColor = Colors.blue;
      } else {
        status = AppLocalizations.of(context)!.soilOptimal(selectedCrop.name);
        statusColor = Colors.green;
      }
    } else {
      status = AppLocalizations.of(context)!.selectCrop;
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
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
            Row(
              children: [
                const Icon(Icons.cloud, size: 40, color: Colors.blueAccent),
                const SizedBox(width: 16.0),
                Text(
                  AppLocalizations.of(context)!.weatherForecast,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(_weatherForecast, style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCard() {
    return StreamBuilder<DocumentSnapshot>(
      stream: _controlStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          final controlData = snapshot.data!.data() as Map<String, dynamic>;
          _isAutoMode = controlData['isAutoMode'] ?? true;
          _isValveOn = controlData['isValveOn'] ?? false;
        }

        return Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.irrigationControl,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.automaticMode,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Switch(
                      value: _isAutoMode,
                      onChanged: (value) {
                        setState(() {
                          _isAutoMode = value;
                        });
                        FirebaseFirestore.instance
                            .collection('irrigation_control')
                            .doc('settings')
                            .set({
                              'isAutoMode': value,
                            }, SetOptions(merge: true));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                ElevatedButton.icon(
                  onPressed: _isAutoMode
                      ? null
                      : () {
                          setState(() {
                            _isValveOn = !_isValveOn;
                          });
                          FirebaseFirestore.instance
                              .collection('irrigation_control')
                              .doc('settings')
                              .set({
                                'isValveOn': _isValveOn,
                              }, SetOptions(merge: true));
                        },
                  icon: Icon(_isValveOn ? Icons.power_off : Icons.power),
                  label: Text(_isValveOn
                      ? AppLocalizations.of(context)!.turnValveOff
                      : AppLocalizations.of(context)!.turnValveOn),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton.icon(
                  onPressed: () {
                    // Placeholder for timer functionality
                  },
                  icon: const Icon(Icons.timer),
                  label: Text(AppLocalizations.of(context)!.setTimer),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
