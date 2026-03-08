# 🤖 AI Tech-Stack Explorer

แอปพลิเคชัน Flutter สำหรับวิเคราะห์ข่าวหุ้นและเทคโนโลยีด้วย AI (Gemini) พร้อม Bloomberg Dark Theme

---

## 📱 Features

- **AI News Analysis** — วิเคราะห์ข่าวหุ้น/โค้ดด้วย Gemini AI
- **ML Kit OCR** — สแกนข้อความจากรูปภาพ (Android/iOS)
- **Journal** — บันทึกความคิดพร้อม mood tracker
- **Dashboard** — แสดงสถิติและกราฟด้วย fl_chart
- **Dark/Light Theme** — Bloomberg Dark Theme
- **Offline Support** — เก็บข้อมูลด้วย Drift (SQLite)

---

## 🏗️ Architecture

```
lib/
├── core/
│   ├── di/          # Dependency Injection (GetIt)
│   ├── router/      # Navigation (AutoRoute)
│   └── theme/       # App Theme
└── features/
    ├── news_analysis/
    │   ├── data/        # Repository, DataSource, Models
    │   ├── domain/      # Entities, UseCases
    │   └── presentation/ # BLoC, Pages
    ├── journal/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── dashboard/
    └── settings/
```

**Pattern:** Clean Architecture + BLoC Pattern

| Layer | Technology |
|-------|-----------|
| State Management | flutter_bloc |
| Navigation | auto_route |
| Local Database | Drift (SQLite) |
| AI | Google Gemini API |
| OCR | Google ML Kit |
| DI | GetIt |

---

## 🚀 วิธีรันโปรเจกต์

### Prerequisites
- Flutter 3.24.5
- Dart 3.5.4
- Android Studio / VS Code
- Android Emulator หรือ Android Device

### 1. Clone Repository

```bash
git clone https://github.com/ChonnipaP/AI-Tech-Stack-Explorer.git
cd AI-Tech-Stack-Explorer
```

### 2. สร้างไฟล์ .env

สร้างไฟล์ `.env` ที่ root ของโปรเจกต์:

```env
GEMINI_API_KEY=your_gemini_api_key_here
```

> 🔑 ขอ API Key ได้ที่ [Google AI Studio](https://aistudio.google.com/)

### 3. ติดตั้ง Dependencies

```bash
flutter pub get
```

### 4. รันแอป

```bash
# Android
flutter run -d emulator-5554

# Windows
flutter run -d windows
```

---

## 🧪 การรัน Tests

```bash
# Unit Test + Widget Test
flutter test

# Integration Test (ต้องเปิด emulator ก่อน)
flutter test integration_test/app_test.dart -d emulator-5554
```

---

## 📦 Build Release

```bash
# Android APK
flutter build apk --release

# Windows
flutter build windows --release
```

APK อยู่ที่: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📁 โครงสร้างไฟล์สำคัญ

```
ai_techstack_explorer/
├── lib/
│   ├── main.dart
│   ├── core/
│   └── features/
├── test/                    # Unit & Widget Tests
├── integration_test/        # Integration Tests
├── android/
├── windows/
├── .env                     # ไม่ได้ upload (gitignore)
├── .env.example             # ตัวอย่าง env
└── pubspec.yaml
```

---

## ⚙️ Environment Variables

| Variable | Description |
|----------|-------------|
| `GEMINI_API_KEY` | Google Gemini API Key |

> ⚠️ **ห้าม** commit ไฟล์ `.env` ขึ้น GitHub เด็ดขาด

---

## 👩‍💻 Developer

**ChonnipaP** — [GitHub](https://github.com/ChonnipaP)
