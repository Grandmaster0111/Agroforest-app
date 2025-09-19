# AgroSmart App Blueprint

## Overview

AgroSmart is a Flutter application designed to help farmers and gardeners manage their irrigation systems intelligently. The app provides a user-friendly interface to monitor and control water usage, ensuring that crops and plants receive the optimal amount of water while conserving resources.

## Style, Design, and Features

### Initial Version

*   **Theme:** The application uses a modern Material 3 design with a green color scheme, reflecting the agricultural theme. It supports both light and dark modes.
*   **Typography:** The app uses the Oswald, Roboto, and Open Sans fonts from Google Fonts to create a clean and readable text hierarchy.
*   **Authentication:** The app uses Firebase Authentication to manage user accounts. Users can sign up and sign in with their email and password.
*   **Routing:** The app uses the `go_router` package for navigation, with a protected home route that redirects to a login screen if the user is not authenticated.
*   **Home Screen:** The home screen welcomes the user and provides a central point for accessing the app's features.

## Current Plan

*   **Task:** Implement email/password authentication with Firebase.
*   **Steps:**
    *   Add Firebase dependencies to the project.
    *   Configure Firebase for the Android platform.
    *   Create an `AuthService` to handle authentication logic.
    *   Create a `LoginScreen` for users to sign in and sign up.
    *   Set up `go_router` to handle authentication-based routing.
    *   Add a logout button to the home screen.
