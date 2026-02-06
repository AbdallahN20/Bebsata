# Bebsata Market

A premium Flutter e-commerce app with Clean Architecture, modular feature structure, dark theme support, and optimized performance.

![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![Platforms](https://img.shields.io/badge/Platforms-Android%20|%20iOS%20|%20Web-green.svg)

## ✨ Features

### Core
- 🌗 **Dark/Light Theme** - Persistent theme (saved locally with SharedPreferences)
- 🛒 **Shopping Cart** - Add, remove, update quantities, clear all
- ❤️ **Favorites** - Synced across all screens with clear all option
- 📦 **Product Catalog** - Browse by category with filtering
- 🔍 **Search** - Find products quickly
- 💳 **Payment Flow** - Checkout with multiple payment methods
- 👤 **Profile Screen** - Stats card, quick actions, settings

### Screens
- Splash Screen with animations
- Welcome / Sign In / Sign Up (Auth flow)
- Home with offers banner & categories
- Product Details with add to cart
- Cart with checkout & clear button
- Favorites with clear button
- Profile with stats & menu
- Orders (Active/Completed/Cancelled)
- Support with Chat Bot
- Rate App (5-star rating)
- Settings (Theme toggle, notifications)
- Navigation Drawer with profile sheet

### Performance
- ⚡ **Optimized widgets** - No heavy BackdropFilter
- 📦 **Tree-shaking** - 99% icon font reduction
- 🌐 **Web compatible** - Builds for web
- 🖼️ **Cached images** - Using cached_network_image

## 🏗️ Architecture

Each feature follows the **screens / widgets / providers** pattern for scalability:

```
lib/
├── core/
│   ├── constants/        # App constants
│   ├── routes/           # Centralized AppRoutes
│   ├── theme/            # AppTheme + ThemeProvider
│   └── widgets/          # GlassContainer (shared)
│
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       └── screens/  # welcome, sign_in, sign_up
│   │
│   ├── cart/
│   │   └── presentation/
│   │       ├── screens/  # cart_screen
│   │       ├── widgets/  # cart_widgets (CartItemCard, QuantitySelector, etc.)
│   │       └── providers/# cart_provider
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/  # home_screen
│   │       └── widgets/  # home_widgets (OfferBanner, CategoryItem, etc.)
│   │
│   ├── navigation/
│   │   └── presentation/
│   │       ├── screens/  # main_screen
│   │       └── widgets/  # app_drawer, drawer_widgets, profile_bottom_sheet
│   │
│   ├── shop/
│   │   ├── presentation/
│   │   │   ├── screens/  # all_products, product_details, favorites
│   │   │   ├── widgets/  # product_card
│   │   │   └── providers/# shop_provider
│   │   ├── domain/
│   │   │   └── entities/ # product, category
│   │   └── data/         # demo_data
│   │
│   ├── user/
│   │   └── presentation/
│   │       ├── screens/  # profile_screen
│   │       ├── widgets/  # profile_widgets (ProfileHeader, ProfileMenuItem, etc.)
│   │       └── providers/# user_provider
│   │
│   ├── settings/
│   │   └── presentation/
│   │       └── screens/  # settings_screen (with SettingsCard, SettingsTile widgets)
│   │
│   ├── orders/           # Orders screen
│   ├── payment/          # Payment flow
│   ├── rate/             # Rate app
│   ├── splash/           # Splash screen
│   └── support/          # Support chat bot
│
└── main.dart
```

## 🚀 Getting Started

```bash
# Clone
git clone https://github.com/yourusername/bebsata.git
cd bebsata

# Install dependencies
flutter pub get

# Run
flutter run

# Build for web
flutter build web --release
```

## 📱 Platforms

| Platform | Status |
|----------|--------|
| Android  | ✅ |
| iOS      | ✅ |
| Web      | ✅ |

## 🛠️ Dependencies

- `provider` - State management
- `google_fonts` - Typography
- `shared_preferences` - Persistent theme storage
- `cached_network_image` - Image caching

## 📂 Key Widget Separations

| Feature | Widgets File | Contains |
|---------|--------------|----------|
| Cart | `cart_widgets.dart` | CartItemCard, QuantitySelector, CartCheckoutSection, EmptyCartView |
| Home | `home_widgets.dart` | OfferBanner, CategoryItem, SectionHeader, HomeSearchBar |
| Profile | `profile_widgets.dart` | ProfileHeader, ProfileMenuItem, ProfileStatsCard |
| Drawer | `drawer_widgets.dart` | AppDrawerHeader, DrawerMenuItem, DrawerThemeToggle, DrawerLogoutButton |
| Settings | `settings_screen.dart` | SettingsSectionHeader, SettingsCard, SettingsListTile, SettingsSwitchTile |

## 📄 License

MIT License

---
Built with ❤️ using Flutter
