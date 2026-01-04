# 'appy app 🌟

A next-generation "Super App" ecosystem built for performance and beauty.
This monorepo contains both the high-performance Flutter frontend and the robust Python backend.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Flutter](https://img.shields.io/badge/Frontend-Flutter_3.0+-02569B.svg)
![Python](https://img.shields.io/badge/Backend-FastAPI-3776AB.svg)

## 📂 Project Structure

*   **`lighthouse_master/`**: The Frontend Application (Flutter).
    *   **Immersive Glass UI**: A stunning, translucent interface designed for 120Hz displays.
    *   **Cross-Platform**: Runs on Linux, Web, Android, and iOS.
*   **`backend/`**: The Backend Service (Python/FastAPI).
    *   **API**: High-performance REST API services.
    *   **Logic**: Handles business logic, data processing, and safety checks.

## ✨ Key Features

*   **Unified Super App**: Chat, Contacts, Discovery, and Digital Wallet in one smooth experience.
*   **Visual Excellence**: Signature "Gold & Teal" Art Deco theme with glassmorphism effects.
*   **Performance First**: Optimized for fluid 120fps rendering on supported hardware.

## 🚀 Getting Started

### 1. Prerequisites
*   **Flutter SDK** (3.0 or higher)
*   **Python** (3.8 or higher)
*   **Git**

### 2. Setup

Clone the repository:
```bash
git clone https://github.com/hoitsi/appyapp.git
cd appyapp
```

### 3. Running the Frontend (App)
Navigate to the app directory and run:
```bash
cd lighthouse_master
flutter pub get
flutter run -d chrome # Web
flutter run -d linux  # Linux Host
flutter run -d android # Android (Requires Emulator/Device)
```

**Android Studio Setup:**
1. Open Android Studio.
2. Select "Open Project" and choose `lighthouse_master/android`.
3. Let Gradle sync, then press Run ▶️ to launch on an emulator.

### 4. Running the Backend (API)
Navigate to the backend directory and run:
```bash
cd backend
pip install -r requirements.txt # If applicable
uvicorn main:app --reload
```

## 🎨 Theme Identity

The application is built around a premium **Light Art Deco** identity:
*   **Primary Action**: `#D4AF37` (Art Deco Gold)
*   **Secondary/Accent**: `#0F4C5C` (Deep Teal)
*   **Background**: Cream-to-White Soft Gradient

## 📄 License

This project is licensed under the MIT License.
