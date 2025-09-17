// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'स्मार्ट सिंचाई';

  @override
  String get home => 'गृह';

  @override
  String get analytics => 'विश्लेषण';

  @override
  String get realTimeSensorData => 'वास्तविक-समय सेन्सर डेटा';

  @override
  String get soilMoisture => 'माटोको चिस्यान';

  @override
  String get temperature => 'तापक्रम';

  @override
  String get humidity => 'आर्द्रता';

  @override
  String get waterTankLevel => 'पानीको ट्याङ्कीको स्तर';

  @override
  String get weatherForecast => 'मौसम पूर्वानुमान';

  @override
  String get irrigationControl => 'सिंचाई नियन्त्रण';

  @override
  String get automaticMode => 'स्वचालित मोड';

  @override
  String get turnValveOn => 'भल्भ खोल्नुहोस्';

  @override
  String get turnValveOff => 'भल्भ बन्द गर्नुहोस्';

  @override
  String get setTimer => 'टाइमर सेट गर्नुहोस्';

  @override
  String get moistureTrends => 'चिस्यान प्रवृत्ति';

  @override
  String get irrigationCycles => 'सिंचाई चक्र';

  @override
  String get tankLevelTrends => 'ट्याङ्की स्तर प्रवृत्ति';

  @override
  String get crop => 'बाली';

  @override
  String get selectCrop => 'सिंचाई सल्लाह हेर्न बाली चयन गर्नुहोस्';

  @override
  String soilDry(Object cropName) {
    return '$cropName को लागि माटो सुख्खा छ - सिंचाई आवश्यक छ';
  }

  @override
  String soilWet(Object cropName) {
    return '$cropName को लागि माटो भिजेको छ - सिंचाई आवश्यक छैन';
  }

  @override
  String soilOptimal(Object cropName) {
    return '$cropName को लागि माटोको चिस्यान इष्टतम छ';
  }

  @override
  String get waterTankLow =>
      'पानीको ट्याङ्की कम छ। पानी बचत गर्ने अभ्यासहरू विचार गर्नुहोस्।';

  @override
  String get waterTankFull => 'पानीको ट्याङ्की लगभग भरिएको छ।';

  @override
  String get waterTankOptimal => 'पानीको ट्याङ्कीको स्तर इष्टतम छ।';
}
