# Project Blueprint: Smart Irrigation App

## Overview

This Flutter application provides a smart irrigation solution for farmers. It displays real-time sensor data from a farm, including soil moisture, temperature, humidity, and water tank levels. The app also features a Crop Intelligence Module that provides irrigation recommendations, manual override controls, and water tank monitoring.

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
*   **Intelligent Irrigation Advice:** The app checks the current soil moisture against the selected crop's ideal range and provides one of the following recommendations:
    *   "Soil is dry for [Crop Name] – irrigation required" (in red)
    *   "Soil moisture is optimal for [Crop Name]" (in green)
    *   "Soil is wet for [Crop Name] – no irrigation needed" (in blue)

### Weather Forecast

*   **Weather Display:** The app fetches and displays the current weather conditions and temperature from WeatherAPI.com.
*   **API Integration:** The app uses the WeatherAPI.com API to get real-time weather data.

### Irrigation Control

*   **Firestore Integration:** App state is synchronized with the `irrigation_control` document in Firestore.
*   **Mode Selection:** A toggle switch allows the user to switch between `Automatic` and `Manual` irrigation modes.
*   **Manual Override:** In manual mode, a button allows the user to turn the water valve `ON` or `OFF` directly.
*   **Timer (Placeholder):** A button is included as a placeholder for future timer/scheduling functionality.

## Design

*   **UI Framework:** The app is built with Flutter and uses Material Design components.
*   **Layout:** The main screen uses a `SingleChildScrollView` to ensure the content is scrollable and avoids overflow errors.
*   **Cards:** The sensor data, crop selection, and status are displayed in `Card` widgets for a clean, organized look.
*   **Color-Coded Status:** The status card is color-coded to provide a quick visual indication of the irrigation status.

## Current Plan

*   **Implement Water Tank Monitoring:** Enhance the UI to include a progress bar for the water tank level and add a new status card for low/overflow alerts and water-saving suggestions.
