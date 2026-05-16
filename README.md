# Agroforest App

A **Flutter** web and mobile application for agroforestry management and land-use planning, backed by **Firebase**.

## Features

- Agroforestry planning and resource management interface
- Real-time data sync via **Firebase Firestore**
- Firebase Authentication for secure accounts
- Deployed as Flutter Web (also supports Android/iOS)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Flutter (Dart) |
| Database | Firebase Firestore |
| Auth | Firebase Authentication |
| Hosting | Firebase Hosting |

## Prerequisites

- Flutter SDK 3.x — [flutter.dev](https://flutter.dev/docs/get-started/install)
- Firebase CLI — `npm install -g firebase-tools`

## Setup

```bash
flutter pub get
flutterfire configure   # connect to your Firebase project
flutter run -d chrome   # web
flutter run             # mobile
```

## Deploy

```bash
flutter build web && firebase deploy
```
