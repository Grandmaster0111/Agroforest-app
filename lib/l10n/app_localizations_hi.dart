// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'स्मार्ट सिंचाई';

  @override
  String get home => 'होम';

  @override
  String get analytics => 'एनालिटिक्स';

  @override
  String get realTimeSensorData => 'रियल-टाइम सेंसर डेटा';

  @override
  String get soilMoisture => 'मिट्टी की नमी';

  @override
  String get temperature => 'तापमान';

  @override
  String get humidity => 'नमी';

  @override
  String get waterTankLevel => 'पानी की टंकी का स्तर';

  @override
  String get weatherForecast => 'मौसम का पूर्वानुमान';

  @override
  String get irrigationControl => 'सिंचाई नियंत्रण';

  @override
  String get automaticMode => 'स्वचालित मोड';

  @override
  String get turnValveOn => 'वाल्व चालू करें';

  @override
  String get turnValveOff => 'वाल्व बंद करें';

  @override
  String get setTimer => 'टाइमर सेट करें';

  @override
  String get moistureTrends => 'नमी के रुझान';

  @override
  String get irrigationCycles => 'सिंचाई चक्र';

  @override
  String get tankLevelTrends => 'टैंक स्तर के रुझान';

  @override
  String get crop => 'फसल';

  @override
  String get selectCrop => 'सिंचाई सलाह देखने के लिए फसल का चयन करें';

  @override
  String soilDry(Object cropName) {
    return '$cropName के लिए मिट्टी सूखी है - सिंचाई की आवश्यकता है';
  }

  @override
  String soilWet(Object cropName) {
    return '$cropName के लिए मिट्टी गीली है - सिंचाई की आवश्यकता नहीं है';
  }

  @override
  String soilOptimal(Object cropName) {
    return '$cropName के लिए मिट्टी की नमी इष्टतम है';
  }

  @override
  String get waterTankLow =>
      'पानी की टंकी कम है। पानी बचाने की प्रथाओं पर विचार करें।';

  @override
  String get waterTankFull => 'पानी की टंकी लगभग भर चुकी है।';

  @override
  String get waterTankOptimal => 'पानी की टंकी का स्तर इष्टतम है।';
}
