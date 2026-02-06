import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/routes/app_routes.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/shop/data/datasources/shop_local_datasource.dart';
import 'features/shop/data/repositories/shop_repository_impl.dart';
import 'features/shop/presentation/providers/shop_provider.dart';
import 'features/user/presentation/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved theme before app starts
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(BebsataApp(themeProvider: themeProvider));
}

class BebsataApp extends StatelessWidget {
  final ThemeProvider themeProvider;

  const BebsataApp({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final shopRepository = ShopRepositoryImpl(
      localDataSource: ShopLocalDataSourceImpl(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
          create: (_) => ShopProvider(shopRepository: shopRepository),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'Bebsata Market',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
