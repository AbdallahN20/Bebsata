# Bebsata Market

A premium Flutter e-commerce mobile app with Clean Architecture and Glassmorphism UI design.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

- **Splash Screen** - Animated intro with smooth transitions
- **Modern UI** - Glassmorphism design with gradient backgrounds
- **Product Catalog** - Browse products by category
- **Shopping Cart** - Add, remove, and update quantities
- **Favorites** - Animated heart with particle effects
- **Category Filtering** - Real-time product filtering
- **Responsive Design** - Works on all screen sizes

## 🏗️ Architecture

This app follows **Clean Architecture** principles:

```
lib/
├── core/                    # Shared utilities
│   ├── constants/           # App constants
│   ├── theme/               # AppTheme, colors, typography
│   └── widgets/             # Reusable widgets (GlassContainer, AnimatedHeart)
├── features/                # Feature modules
│   ├── cart/                # Cart feature
│   │   ├── domain/          # Entities
│   │   └── presentation/    # Screens, providers
│   ├── navigation/          # Bottom navigation
│   ├── shop/                # Shop feature
│   │   ├── data/            # Repositories, data sources
│   │   ├── domain/          # Entities, repository interfaces
│   │   └── presentation/    # Screens, providers, widgets
│   ├── splash/              # Splash screen
│   └── user/                # User/Auth feature
└── main.dart                # App entry point
```

## 🎨 UI Components

| Component | Description |
|-----------|-------------|
| `GlassContainer` | Glassmorphism container with blur effect |
| `AnimatedHeart` | Favorite button with scale animation and particles |
| `ProductCard` | Glass-style product card |
| `MainScreen` | Floating glass bottom navigation |

## 🚀 Getting Started

### Prerequisites

- Flutter 3.0+
- Dart 3.0+

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/bebsata.git
   cd bebsata
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 📱 Screenshots

| Splash | Home | Product Details | Cart |
|--------|------|-----------------|------|
| 🎬 | 🏠 | 📦 | 🛒 |

## 🛠️ Dependencies

- `provider` - State management
- `google_fonts` - Typography
- `convex_bottom_bar` - Bottom navigation

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Built with ❤️ using Flutter
