import 'package:flutter/material.dart';
import 'package:bebsata/features/splash/presentation/screens/splash_screen.dart';
import 'package:bebsata/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bebsata/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:bebsata/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:bebsata/features/navigation/presentation/screens/main_screen.dart';
import 'package:bebsata/features/support/presentation/screens/support_screen.dart';
import 'package:bebsata/features/rate/presentation/screens/rate_screen.dart';
import 'package:bebsata/features/settings/presentation/screens/settings_screen.dart';
import 'package:bebsata/features/orders/presentation/screens/orders_screen.dart';
import 'package:bebsata/features/cart/presentation/screens/cart_screen.dart';
import 'package:bebsata/features/shop/presentation/screens/favorites_screen.dart';

/// Centralized route names for the app
class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String main = '/main';
  static const String support = '/support';
  static const String rate = '/rate';
  static const String settings = '/settings';
  static const String orders = '/orders';
  static const String cart = '/cart';
  static const String favorites = '/favorites';

  /// Generate all routes for MaterialApp
  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashScreen(),
    welcome: (_) => const WelcomeScreen(),
    signIn: (_) => const SignInScreen(),
    signUp: (_) => const SignUpScreen(),
    main: (_) => const MainScreen(),
    support: (_) => const SupportScreen(),
    rate: (_) => const RateScreen(),
    settings: (_) => const SettingsScreen(),
    orders: (_) => const OrdersScreen(),
    cart: (_) => const CartScreen(),
    favorites: (_) => const FavoritesScreen(),
  };

  /// Navigate to a named route
  static Future<T?> navigateTo<T>(BuildContext context, String routeName) {
    return Navigator.pushNamed<T>(context, routeName);
  }

  /// Navigate and replace current route
  static Future<T?> navigateAndReplace<T>(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.pushReplacementNamed<T, void>(context, routeName);
  }

  /// Navigate and clear all previous routes
  static Future<T?> navigateAndClearStack<T>(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
    );
  }

  /// Pop current route
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
