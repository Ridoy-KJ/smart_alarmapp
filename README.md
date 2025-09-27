# 🌍 Smart Travel Alarm App

A Flutter onboarding app that syncs alarms with your location and travel rhythm — built to match the provided Figma design.

## 📱 Features

- ✨ Figma-aligned onboarding screens (3 steps)
- 📍 Location permission prompt and display
- ⏰ Alarm setting with toggle and time picker
- 🔔 Local notifications (via `flutter_local_notifications`)
- 💾 Optional local storage (expandable)

## 🧰 Tools & Packages Used

- `flutter_local_notifications`
- `geolocator`
- `geocoding`
- `provider`
- `intl`
- `video_player`

## 📦 Project Structure

lib/
├── common_widgets/   # Reusable UI components (e.g., AlarmListTile)
├── constants/        # App-wide styles, colors, and assets
├── features/
│   ├── onboarding/   # Onboarding flow (screen + viewmodel)
│   ├── location/     # Location permission and display
│   └── home/         # Alarm management and home UI
├── helpers/          # Utility services (location, notifications)
├── networks/         # Reserved for future API integrations
└── main.dart         # App entry point


## 🚀 Getting Started

```bash
flutter pub get
flutter run



##📸 Screenshots

| Onboarding | Location | Home |
|------------|----------|------|
| ![Onboarding](screenshots/onboarding.png) | ![Location](screenshots/location.png) | ![Home](screenshots/home.png) |


    

🎥 Demo Video
Watch the app in action: "https://www.loom.com/share/17163e55f4bf4552b70cd487f716aadd"