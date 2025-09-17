// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Smart Irrigation';

  @override
  String get home => 'Home';

  @override
  String get analytics => 'Analytics';

  @override
  String get realTimeSensorData => 'Real-time Sensor Data';

  @override
  String get soilMoisture => 'Soil Moisture';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get waterTankLevel => 'Water Tank Level';

  @override
  String get weatherForecast => 'Weather Forecast';

  @override
  String get irrigationControl => 'Irrigation Control';

  @override
  String get automaticMode => 'Automatic Mode';

  @override
  String get turnValveOn => 'Turn Valve ON';

  @override
  String get turnValveOff => 'Turn Valve OFF';

  @override
  String get setTimer => 'Set Timer';

  @override
  String get moistureTrends => 'Moisture Trends';

  @override
  String get irrigationCycles => 'Irrigation Cycles';

  @override
  String get tankLevelTrends => 'Tank Level Trends';

  @override
  String get crop => 'Crop';

  @override
  String get selectCrop => 'Select a crop to see irrigation advice';

  @override
  String soilDry(Object cropName) {
    return 'Soil is dry for $cropName – irrigation required';
  }

  @override
  String soilWet(Object cropName) {
    return 'Soil is wet for $cropName – no irrigation needed';
  }

  @override
  String soilOptimal(Object cropName) {
    return 'Soil moisture is optimal for $cropName';
  }

  @override
  String get waterTankLow =>
      'Water tank is low. Consider water-saving practices.';

  @override
  String get waterTankFull => 'Water tank is almost full.';

  @override
  String get waterTankOptimal => 'Water tank level is optimal.';
}
