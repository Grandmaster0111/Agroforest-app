# Project Blueprint: Smart Irrigation App

## Overview

This Flutter application provides a smart irrigation solution for farmers. It displays real-time sensor data from a farm, including soil moisture, temperature, humidity, and water tank levels. The app also features a Crop Intelligence Module that provides irrigation recommendations based on the selected crop.

## Features

### Real-time Sensor Data

*   **Real-time Updates:** The app streams data from a Cloud Firestore database and displays it in real-time.
*   **Sensor Cards:** The following sensor data is displayed in individual cards:
    *   Soil Moisture (%)
    *   Temperature (°C)
    *   Humidity (%)
    *   Water Tank Level (%)

### Crop Intelligence Module

*   **Crop Selection:** A dropdown menu allows farmers to select the crop they are growing.
*   **Crop Database:** A local database (currently a static list in `CropService`) stores the ideal moisture range for each crop.
*   **Intelligent Irrigation Advice:** The app checks the current soil moisture against the selected crop's ideal range and provides one of the following recommendations:
    *   "Soil is dry for [Crop Name] – irrigation required" (in red)
    *   "Soil moisture is optimal for [Crop Name]" (in green)
    *   "Soil is wet for [Crop Name] – no irrigation needed" (in blue)

### Weather Forecast

*   **Weather Display:** The app fetches and displays a 3-day weather forecast.
*   **API Integration:** The weather forecast is fetched from a weather API (currently a placeholder).

## Design

*   **UI Framework:** The app is built with Flutter and uses Material Design components.
*   **Layout:** The main screen uses a `SingleChildScrollView` to ensure the content is scrollable and avoids overflow errors.
*   **Cards:** The sensor data, crop selection, and status are displayed in `Card` widgets for a clean, organized look.
*   **Color-Coded Status:** The status card is color-coded to provide a quick visual indication of the irrigation status.

## Current Plan

*   **Fix Overflow Error:** The last completed task was to fix the UI overflow error by wrapping the main `Column` in a `SingleChildScrollView`.
