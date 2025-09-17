import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/intl.dart' as intl;

/// Call methods on this class to get the localized string.
///
/// To make this class available in your app, add the following to your
/// MaterialApp's `localizationsDelegates` array:
///
/// ```dart
///   localizationsDelegates: [
///     AppLocalizations.delegate,
///     GlobalMaterialLocalizations.delegate,
///     GlobalWidgetsLocalizations.delegate,
///     GlobalCupertinoLocalizations.delegate,
///   ],
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
/// dev_dependencies:
///   flutter_test:
///     sdk: flutter
///
/// flutter:
///   uses-material-design: true
///   generate: true
/// ```
///
/// ## Labels
///
/// The labels defined in this file are simple strings that can be used for
/// buttons, titles, descriptions, and other text in your app. The values
/// in this file are the English translations of the labels.
///
/// To add a new label, add a property to this class and provide a
/// translation in each of the supported language files in the
/// `lib/src/l10n` directory.
///
/// ## Messages
///
/// The messages defined in this file are functions that take arguments and
/// return a string. The values in this file are the English translations of
/// the messages. The function signature must be the same in all of the
/// supported language files.
///
/// To add a new message, add a function to this class and provide a
/// translation in each of the supported language files in the
/// `lib/src/l10n` directory.

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending them to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Irrigation'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @realTimeSensorData.
  ///
  /// In en, this message translates to:
  /// **'Real-time Sensor Data'**
  String get realTimeSensorData;

  /// No description provided for @soilMoisture.
  ///
  /// In en, this message translates to:
  /// **'Soil Moisture'**
  String get soilMoisture;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @waterTankLevel.
  ///
  /// In en, this message translates to:
  /// **'Water Tank Level'**
  String get waterTankLevel;

  /// No description provided for @waterTankLow.
  ///
  /// In en, this message translates to:
  /// **'Water Tank Low'**
  String get waterTankLow;

  /// No description provided for @waterTankFull.
  ///
  /// In en, this message translates to:
  /// **'Water Tank Full'**
  String get waterTankFull;

  /// No description provided for @waterTankOptimal.
  ///
  /// In en, this message translates to:
  /// **'Water Tank Optimal'**
  String get waterTankOptimal;

  /// No description provided for @soilDry.
  ///
  /// In en, this message translates to:
  /// **'Soil is too dry for {cropName}'**
  String soilDry(String cropName);

  /// No description provided for @soilWet.
  ///
  /// In en, this message translates to:
  /// **'Soil is too wet for {cropName}'**
  String soilWet(String cropName);

  /// No description provided for @soilOptimal.
  ///
  /// In en, this message translates to:
  /// **'Soil moisture is optimal for {cropName}'**
  String soilOptimal(String cropName);

  /// No description provided for @selectCrop.
  ///
  /// In en, this message translates to:
  /// **'Select a crop to see status'**
  String get selectCrop;

  /// No description provided for @weatherForecast.
  ///
  /// In en, this message translates to:
  /// **'Weather Forecast'**
  String get weatherForecast;

  /// No description provided for @irrigationControl.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Control'**
  String get irrigationControl;

  /// No description provided for @automaticMode.
  ///
  /// In en, this message translates to:
  /// **'Automatic Mode'**
  String get automaticMode;

  /// No description provided for @turnValveOn.
  ///
  /// In en, this message translates to:
  /// **'Turn Valve On'**
  String get turnValveOn;

  /// No description provided for @turnValveOff.
  ///
  /// In en, this message translates to:
  /// **'Turn Valve Off'**
  String get turnValveOff;

  /// No description provided for @setTimer.
  ///
  /// In en, this message translates to:
  /// **'Set Timer'**
  String get setTimer;

  /// No description provided for @moistureTrends.
  ///
  /// In en, this message translates to:
  /// **'Moisture Trends'**
  String get moistureTrends;

  /// No description provided for @irrigationCycles.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Cycles'**
  String get irrigationCycles;

  /// No description provided for @tankLevelTrends.
  ///
  /// In en, this message translates to:
  /// **'Tank Level Trends'**
  String get tankLevelTrends;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Lookup logic when only language code is specified.
    switch (locale.languageCode) {
      case 'en': return SynchronousFuture<AppLocalizations>(AppLocalizationsEn());
      case 'es': return SynchronousFuture<AppLocalizations>(AppLocalizationsEs());
    }

    return SynchronousFuture<AppLocalizations>(AppLocalizationsEn());
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn() : super('en');

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
  String get waterTankLow => 'Water Tank Low';

  @override
  String get waterTankFull => 'Water Tank Full';

  @override
  String get waterTankOptimal => 'Water Tank Optimal';

  @override
  String soilDry(String cropName) {
    return 'Soil is too dry for $cropName';
  }

  @override
  String soilWet(String cropName) {
    return 'Soil is too wet for $cropName';
  }

  @override
  String soilOptimal(String cropName) {
    return 'Soil moisture is optimal for $cropName';
  }

  @override
  String get selectCrop => 'Select a crop to see status';

  @override
  String get weatherForecast => 'Weather Forecast';

  @override
  String get irrigationControl => 'Irrigation Control';

  @override
  String get automaticMode => 'Automatic Mode';

  @override
  String get turnValveOn => 'Turn Valve On';

  @override
  String get turnValveOff => 'Turn Valve Off';

  @override
  String get setTimer => 'Set Timer';

  @override
  String get moistureTrends => 'Moisture Trends';

  @override
  String get irrigationCycles => 'Irrigation Cycles';

  @override
  String get tankLevelTrends => 'Tank Level Trends';
}

class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs() : super('es');

  @override
  String get appTitle => 'Riego Inteligente';

  @override
  String get home => 'Inicio';

  @override
  String get analytics => 'Analíticas';

  @override
  String get realTimeSensorData => 'Datos de sensores en tiempo real';

  @override
  String get soilMoisture => 'Humedad del suelo';

  @override
  String get temperature => 'Temperatura';

  @override
  String get humidity => 'Humedad';

  @override
  String get waterTankLevel => 'Nivel del tanque de agua';

  @override
  String get waterTankLow => 'Nivel de agua bajo';

  @override
  String get waterTankFull => 'Nivel de agua lleno';

  @override
  String get waterTankOptimal => 'Nivel de agua óptimo';

  @override
  String soilDry(String cropName) {
    return 'El suelo está demasiado seco para $cropName';
  }

  @override
  String soilWet(String cropName) {
    return 'El suelo está demasiado húmedo para $cropName';
  }

  @override
  String soilOptimal(String cropName) {
    return 'La humedad del suelo es óptima para $cropName';
  }

  @override
  String get selectCrop => 'Seleccione un cultivo para ver el estado';

  @override
  String get weatherForecast => 'Pronóstico del tiempo';

  @override
  String get irrigationControl => 'Control de riego';

  @override
  String get automaticMode => 'Modo automático';

  @override
  String get turnValveOn => 'Abrir la válvula';

  @override
  String get turnValveOff => 'Cerrar la válvula';

  @override
  String get setTimer => 'Establecer temporizador';

  @override
  String get moistureTrends => 'Tendencias de humedad';

  @override
  String get irrigationCycles => 'Ciclos de riego';

  @override
  String get tankLevelTrends => 'Tendencias del nivel del tanque';
}
