# Flutter ToDo App

This is a simple ToDo application built with Flutter, powered by Back4App for backend services. It allows users to register, log in, manage their tasks (add, edit, delete, mark as complete), and switch between light and dark themes.

## Features

-   **User Authentication:**
    -   User Registration with email and password.
    -   User Login with email and password.
    -   User Logout.
-   **Task Management:**
    -   Add new tasks with a title and description.
    -   Edit existing tasks.
    -   Delete tasks.
    -   Toggle task completion status.
-   **Theming:**
    -   Supports both Light and Dark themes.
    -   Theme preference is saved locally.
-   **Cross-Platform:**
    -   Designed to run on iOS and Android (and potentially web/desktop with Flutter's capabilities).

## Technologies Used

-   **Flutter:** UI Toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
-   **Dart:** Programming language used by Flutter.
-   **`parse_server_sdk_flutter`:** Flutter SDK for Parse Server, used for backend communication with Back4App.
-   **Back4App:** A Parse Server hosting platform providing database, authentication, and cloud functions.
-   **`provider`:** State management solution for Flutter.
-   **`shared_preferences`:** Used for local storage of user preferences (e.g., theme).

## Setup and Installation

Follow these steps to get the project up and running on your local machine.

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and configured.
-   A Back4App account.
-   A GitHub Personal Access Token (for pushing to private repositories, if applicable).

### 1. Clone the Repository

```bash
git clone https://github.com/daniel-vivek/Flutter-To-Do-App.git
cd Flutter-To-Do-App
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Back4App

1.  **Create a Back4App Application:**
    -   Go to [Back4App](https://www.back4app.com/) and create a new app.
    -   Note down your `Application ID` and `Client Key`.

2.  **Update `lib/main.dart`:**
    -   Open `lib/main.dart`.
    -   Replace the placeholder values for `keyApplicationId` and `keyClientKey` with your actual Back4App credentials:

    ```dart
    const keyApplicationId = 'YOUR_BACK4APP_APPLICATION_ID';
    const keyClientKey = 'YOUR_BACK4APP_CLIENT_KEY';
    ```

### 4. Run the Application

```bash
flutter run
```

To run on a specific device or platform:

```bash
flutter run -d <device_id>
flutter run --profile # For profiling performance
flutter run --release # For a release build
```

### Youtube Link

https://youtu.be/a7y9Cl0a_FI

## Theming

The application supports both light and dark themes. The theme can be toggled from the settings screen, and your preference will be saved locally using `shared_preferences`.

-   **Light Theme:** Default theme with a bright background and dark text.
-   **Dark Theme:** A darker interface, designed for reduced eye strain in low-light conditions.

The primary color used throughout the application is a custom purple (`#D8C3FA`), inspired by the Zuddl logo.

## Screenshots

### iOS Screenshots

<p align="center">
  <img src="task_manager/lib/screenshots/ios/IMG_5433.PNG" width="30%" alt="iOS Screenshot 1">
  <img src="task_manager/lib/screenshots/ios/IMG_5434.PNG" width="30%" alt="iOS Screenshot 2">
  <img src="task_manager/lib/screenshots/ios/IMG_5435.PNG" width="30%" alt="iOS Screenshot 3">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/ios/IMG_5436.PNG" width="30%" alt="iOS Screenshot 4">
  <img src="task_manager/lib/screenshots/ios/IMG_5437.PNG" width="30%" alt="iOS Screenshot 5">
  <img src="task_manager/lib/screenshots/ios/IMG_5438.PNG" width="30%" alt="iOS Screenshot 6">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/ios/IMG_5439.PNG" width="30%" alt="iOS Screenshot 7">
  <img src="task_manager/lib/screenshots/ios/IMG_5440.PNG" width="30%" alt="iOS Screenshot 8">
  <img src="task_manager/lib/screenshots/ios/IMG_5441.PNG" width="30%" alt="iOS Screenshot 9">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/ios/IMG_5442.PNG" width="30%" alt="iOS Screenshot 10">
  <img src="task_manager/lib/screenshots/ios/IMG_5443.PNG" width="30%" alt="iOS Screenshot 11">
  <img src="task_manager/lib/screenshots/ios/IMG_5444.PNG" width="30%" alt="iOS Screenshot 12">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/ios/IMG_5445.PNG" width="30%" alt="iOS Screenshot 13">
  <img src="task_manager/lib/screenshots/ios/IMG_5446.PNG" width="30%" alt="iOS Screenshot 14">
  <img src="task_manager/lib/screenshots/ios/IMG_5447.PNG" width="30%" alt="iOS Screenshot 15">
</p>

### Android Screenshots

<p align="center">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_144907.png" width="30%" alt="Android Screenshot 1">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_144928.png" width="30%" alt="Android Screenshot 2">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_144951.png" width="30%" alt="Android Screenshot 3">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_144958.png" width="30%" alt="Android Screenshot 4">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145003.png" width="30%" alt="Android Screenshot 5">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145014.png" width="30%" alt="Android Screenshot 6">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145022.png" width="30%" alt="Android Screenshot 7">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145028.png" width="30%" alt="Android Screenshot 8">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145040.png" width="30%" alt="Android Screenshot 9">
</p>
<p align="center">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145051.png" width="30%" alt="Android Screenshot 10">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145100.png" width="30%" alt="Android Screenshot 11">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145107.png" width="30%" alt="Android Screenshot 12">
  <img src="task_manager/lib/screenshots/android/Screenshot_20251115_145116.png" width="30%" alt="Android Screenshot 13">
</p>

## Contributing

Feel free to fork the repository, make improvements, and submit pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
