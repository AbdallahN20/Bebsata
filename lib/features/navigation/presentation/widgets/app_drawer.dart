import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/theme_provider.dart';
import 'package:bebsata/core/routes/app_routes.dart';
import 'package:bebsata/features/user/presentation/providers/user_provider.dart';
import 'package:bebsata/features/shop/presentation/screens/favorites_screen.dart';
import 'drawer_widgets.dart';
import 'profile_bottom_sheet.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // Header
            AppDrawerHeader(
              name: user.name,
              email: user.email.isNotEmpty ? user.email : null,
              onTap: () {
                Navigator.pop(context);
                _showProfileSheet(context, user);
              },
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  DrawerMenuItem(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      _showProfileSheet(context, user);
                    },
                  ),
                  DrawerMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    onTap: () => _navigateTo(context, AppRoutes.orders),
                  ),
                  DrawerMenuItem(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Cart',
                    onTap: () => _navigateTo(context, AppRoutes.cart),
                  ),
                  DrawerMenuItem(
                    icon: Icons.favorite_outline,
                    title: 'Favorites',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  DrawerMenuItem(
                    icon: Icons.headset_mic_outlined,
                    title: 'Support',
                    onTap: () => _navigateTo(context, AppRoutes.support),
                  ),
                  DrawerMenuItem(
                    icon: Icons.star_outline,
                    title: 'Rate App',
                    onTap: () => _navigateTo(context, AppRoutes.rate),
                  ),
                  DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => _navigateTo(context, AppRoutes.settings),
                  ),
                  const Divider(),
                  DrawerThemeToggle(
                    isDark: theme.isDarkMode,
                    onToggle: () => theme.toggleTheme(),
                  ),
                ],
              ),
            ),

            // Logout
            if (user.isLoggedIn)
              DrawerLogoutButton(
                onLogout: () {
                  user.logout();
                  AppRoutes.navigateAndReplace(context, AppRoutes.welcome);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context);
    AppRoutes.navigateTo(context, route);
  }

  void _showProfileSheet(BuildContext context, UserProvider user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ProfileBottomSheet(user: user),
    );
  }
}
