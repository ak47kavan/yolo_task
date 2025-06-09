# 💳 YOLO Pay - Flutter App

**YOLO Pay** is a futuristic Flutter UI concept for managing digital debit cards. It includes animations, blur effects, and a custom bottom navigation bar with smooth transitions.

This app also integrates with a Node.js + Faker.js backend API to fetch realistic random card data for testing purposes.

---

## ✨ Features

- 🧊 Blur effect on card when frozen
- ❄️ Freeze/Unfreeze toggle with animation
- 🕹️ Custom bottom navigation bar with animation and active indicators
- 📇 Fetches realistic card details from a mock API using `faker.js`
- 📱 Clean, minimal, dark-themed modern UI

---

## 🛠️ Built With

- **Flutter** (UI, animations)
- **Faker.js API** (Node.js + Express backend for fake card data)
- `google_fonts` (for Poppins font)
- `dart:ui` (for blur effect)
- REST API (for fetching card data)

---

## 📸 Screenshots

| Main Card UI | Blur Effect | Bottom Navigation |
|--------------|-------------|-------------------|
| ![card](screenshots/card_ui.png) | ![blur](screenshots/blur_effect.png) | ![nav](screenshots/bottom_nav.png) |

> (Add your own screenshots in `/screenshots/` folder)

---

## 📦 Project Structure

```bash
lib/
│
├── models/
│   └── card_model.dart         # CardModel for JSON response
│
├── services/
│   └── faker_service.dart      # API call to Faker backend
│
├── components/
│   └── custom_bottom_navbar.dart  # Animated bottom nav bar
│
├── screens/
│   └── yolo_pay_screen.dart    # Main UI screen with blur effect
│
└── main.dart                   # Entry point
