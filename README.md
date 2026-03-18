# Blood Pressure Diary — Offline-first BP Tracker

Offline-first mobile app for tracking blood pressure  
with local data storage, clear analytics, and AI-powered insights.

---

## 🚀 Overview

This app is designed for simple and consistent tracking of blood pressure data  
with an offline-first approach and full control over your data.

Designed for daily use without unnecessary complexity.

Core idea:
- keep all data locally
- provide clear and useful analytics
- add AI insights without overcomplicating UX

---

## ✨ Features (MVP)

- Add and manage blood pressure readings (SBP / DBP / pulse)
- View measurement history
- Basic statistics and charts
- AI insights for selected period *(planned)*
- Reminders *(planned)*
- Export to PDF *(planned)*

---

## 🧠 Disclaimer

This application is not a medical device and does not provide diagnoses.

AI-generated insights:
- may be inaccurate
- are intended for informational purposes only

Consult a healthcare professional if needed.

---

## 🏗 Architecture

- Feature-first structure
- BLoC for state management
- Drift (SQLite) for local storage
- Freezed for models and states
- Offline-first approach

---

## ⚙️ Getting Started

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 📌 Status

🚧 MVP in progress

---

## 📄 License

MIT License
