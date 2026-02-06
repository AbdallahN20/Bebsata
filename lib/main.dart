import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/shop/data/datasources/shop_local_datasource.dart';
import 'features/shop/data/repositories/shop_repository_impl.dart';
import 'features/shop/presentation/providers/shop_provider.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/welcome_screen.dart';
import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/auth/presentation/screens/sign_up_screen.dart';
import 'features/navigation/presentation/screens/main_screen.dart';
import 'features/support/presentation/screens/support_screen.dart';
import 'features/rate/presentation/screens/rate_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/orders/presentation/screens/orders_screen.dart';
import 'features/user/presentation/providers/user_provider.dart';

void main() {
  runApp(const BebsataApp());
}

class BebsataApp extends StatelessWidget {
  const BebsataApp({super.key});

  @override
  Widget build(BuildContext context) {
    final shopRepository = ShopRepositoryImpl(
      localDataSource: ShopLocalDataSourceImpl(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
          create: (_) => ShopProvider(shopRepository: shopRepository),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Bebsata Market',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/welcome': (context) => const WelcomeScreen(),
              '/signin': (context) => const SignInScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/main': (context) => const MainScreen(),
              '/support': (context) => const SupportScreen(),
              '/rate': (context) => const RateScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/orders': (context) => const OrdersScreen(),
            },
          );
        },
      ),
    );
  }
}
