
# Project Blueprint

## Overview

This document outlines the plan for implementing a login and registration flow using Firebase Authentication and storing user data in Cloud Firestore. The application will use `go_router` for navigation.

## Current Task: Implement Login and Registration

### Plan

1.  **Firebase Setup:**
    *   Add `firebase_core`, `firebase_auth`, and `cloud_firestore` dependencies to `pubspec.yaml`.
    *   Initialize Firebase in `lib/main.dart`.

2.  **Create Screens:**
    *   `lib/screens/login_screen.dart`: A stateful widget with email and password fields, and a login button.
    *   `lib/screens/register_screen.dart`: A stateful widget with email, password, and confirm password fields, and a register button.
    *   `lib/screens/home_screen.dart`: A simple screen to navigate to after successful login/registration.

3.  **Authentication Service:**
    *   Create `lib/services/auth_service.dart` to handle all Firebase Auth operations (login, registration, sign out).

4.  **Routing:**
    *   Add the `go_router` dependency.
    *   Create `lib/router.dart` to define the routes for `/login`, `/register`, and `/home`.
    *   Implement a redirect logic to check if the user is authenticated. If not, redirect to the login screen.

5.  **Update `main.dart`:**
    *   Modify `main()` to be `async` and initialize Firebase.
    *   Use `MaterialApp.router` to integrate `go_router`.

