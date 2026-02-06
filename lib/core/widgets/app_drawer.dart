import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/theme/theme_provider.dart';
import 'package:bebsata/features/user/presentation/providers/user_provider.dart';
import 'package:bebsata/features/cart/presentation/screens/cart_screen.dart';
import 'package:bebsata/features/rate/presentation/screens/rate_screen.dart';
import 'package:bebsata/features/support/presentation/screens/support_screen.dart';
import 'package:bebsata/features/settings/presentation/screens/settings_screen.dart';
import 'package:bebsata/features/orders/presentation/screens/orders_screen.dart';
import 'package:bebsata/features/shop/presentation/screens/all_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);
    final isDark = theme.isDarkMode;

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // Header - Profile Section (tappable)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _showProfileSheet(context, user);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.edit,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user.email.isNotEmpty)
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      )
                    else
                      Text(
                        'Tap to view profile',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildMenuItem(context, Icons.person_outline, 'Profile', () {
                    Navigator.pop(context);
                    _showProfileSheet(context, user);
                  }),
                  _buildMenuItem(
                    context,
                    Icons.shopping_bag_outlined,
                    'My Orders',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OrdersScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.shopping_cart_outlined,
                    'Cart',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    Icons.favorite_outline,
                    'Favorites',
                    () {
                      Navigator.pop(context);
                      // Navigate to AllProductsScreen which shows favorites
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllProductsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  _buildMenuItem(
                    context,
                    Icons.headset_mic_outlined,
                    'Support',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SupportScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(context, Icons.star_outline, 'Rate App', () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RateScreen()),
                    );
                  }),
                  _buildMenuItem(
                    context,
                    Icons.settings_outlined,
                    'Settings',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  // Theme Toggle
                  ListTile(
                    leading: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: AppTheme.primaryColor,
                    ),
                    title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
                    trailing: Switch(
                      value: isDark,
                      onChanged: (_) => theme.toggleTheme(),
                      activeColor: AppTheme.primaryColor,
                    ),
                    onTap: () => theme.toggleTheme(),
                  ),
                ],
              ),
            ),
            // Logout
            if (user.isLoggedIn)
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      user.logout();
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                    icon: const Icon(Icons.logout, color: AppTheme.errorColor),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: AppTheme.errorColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.errorColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showProfileSheet(BuildContext context, UserProvider user) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Avatar
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.accentColor],
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (user.email.isNotEmpty)
              Text(user.email, style: TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 32),
            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickAction(
                    context,
                    Icons.shopping_bag_outlined,
                    'Orders',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OrdersScreen()),
                      );
                    },
                  ),
                  _buildQuickAction(
                    context,
                    Icons.favorite_outline,
                    'Favorites',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllProductsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildQuickAction(
                    context,
                    Icons.settings_outlined,
                    'Settings',
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (!user.isLoggedIn)
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/welcome');
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
