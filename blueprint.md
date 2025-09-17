# Project Blueprint: Smart Irrigation App

## Overview

This Flutter application provides a smart irrigation solution for farmers. It displays real-time sensor data, provides irrigation recommendations, offers manual controls, monitors water tank levels, and sends proactive alerts.

## Features

### Real-time Sensor Data

*   **Real-time Updates:** The app streams data from a Cloud Firestore database and displays it in real-time.
*   **Sensor Cards:** The following sensor data is displayed in individual cards:
    *   Soil Moisture (%)
    *   Temperature (°C)
    *   Humidity (%)

### Rainwater Harvesting & Water Tank Monitoring

*   **Visual Water Level:** The current water tank level is displayed with a percentage and a visual progress bar.
*   **Status Alerts:** A color-coded card provides alerts based on the water level:
    *   **Low (< 20%):** A red alert warns that the tank is low and suggests water-saving practices.
    *   **Overflowing (> 95%):** A yellow alert warns that the tank is nearly full.
    *   **Optimal (20-95%):** A green card indicates the water level is optimal.

### Crop Intelligence Module

*   **Crop Selection:** A dropdown menu allows farmers to select the crop they are growing.
*   **Crop Database:** A local database (currently a static list in `CropService`) stores the ideal moisture range for each crop.
*   **Intelligent Irrigation Advice:** The app checks the current soil moisture against the selected crop's ideal range and provides irrigation advice.

### Weather Forecast

*   **Weather Display:** The app fetches and displays the current weather conditions and temperature from WeatherAPI.com.
*   **API Integration:** The app uses the WeatherAPI.com API to get real-time weather data.

### Irrigation Control

*   **Firestore Integration:** App state is synchronized with the `irrigation_control` document in Firestore.
*   **Mode Selection:** A toggle switch allows the user to switch between `Automatic` and `Manual` irrigation modes.
*   **Manual Override:** In manual mode, a button allows the user to turn the water valve `ON` or `OFF` directly.
*   **Timer (Placeholder):** A button is included as a placeholder for future timer/scheduling functionality.

### Alerts & Notifications

*   **Push Notifications:** The app is configured to receive push notifications via Firebase Cloud Messaging (FCM).
*   **Backend Logic (Cloud Functions):** Placeholder Cloud Functions are provided to send alerts for:
    *   Critically low soil moisture.
    *   Low water tank levels.
    *   Weather-based irrigation skips (e.g., rain predicted).

### Analytics & History

*   **Data Logging:** The backend will be updated to log historical data for sensor readings and irrigation events.
*   **Charts:** A new analytics screen will display charts for:
    *   Moisture trends over time (line chart).
    *   Irrigation cycles (bar chart).
    *   Water tank level trends (line chart).

## Design

*   **UI Framework:** The app is built with Flutter and uses Material Design components.
*   **Navigation:** The app will use a `BottomNavigationBar` to switch between the Home and Analytics screens.
*   **Layout:** The main screen uses a `SingleChildScrollView` to ensure the content is scrollable.
*   **Cards:** Data and controls are organized in `Card` widgets for a clean look.
*   **Color-Coded Status:** Status cards use color to provide quick visual feedback.

## Current Plan

*   **Implement Analytics & History:** Add the `fl_chart` package, create a new `AnalyticsScreen`, refactor the main app to use a `BottomNavigationBar`, update the backend to log historical data, and build the charts.
