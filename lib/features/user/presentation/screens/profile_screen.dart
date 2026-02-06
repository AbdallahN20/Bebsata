import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/routes/app_routes.dart';
import 'package:bebsata/features/cart/presentation/providers/cart_provider.dart';
import 'package:bebsata/features/shop/presentation/providers/shop_provider.dart';
import 'package:bebsata/features/user/presentation/providers/user_provider.dart';
import 'package:bebsata/features/shop/presentation/screens/favorites_screen.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = Provider.of<UserProvider>(context);
    final shop = Provider.of<ShopProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.darkBackground
          : AppTheme.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => AppRoutes.navigateTo(context, AppRoutes.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            ProfileHeader(
              name: user.name,
              email: user.email.isNotEmpty ? user.email : null,
              isLoggedIn: user.isLoggedIn,
            ),
            const SizedBox(height: 24),

            // Sign In Button (if not logged in)
            if (!user.isLoggedIn) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      AppRoutes.navigateTo(context, AppRoutes.welcome),
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Stats Card
            ProfileStatsCard(
              ordersCount: 0, // TODO: Get from orders provider
              favoritesCount: shop.favoriteIds.length,
              cartCount: cart.itemCount,
              onOrdersTap: () =>
                  AppRoutes.navigateTo(context, AppRoutes.orders),
              onFavoritesTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                );
              },
              onCartTap: () => AppRoutes.navigateTo(context, AppRoutes.cart),
            ),
            const SizedBox(height: 24),

            // Menu Items
            ProfileMenuItem(
              icon: Icons.favorite_outline,
              title: 'My Favorites',
              subtitle: '${shop.favoriteIds.length} items',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                );
              },
              iconColor: Colors.red,
            ),
            ProfileMenuItem(
              icon: Icons.local_shipping_outlined,
              title: 'My Orders',
              subtitle: 'Track your orders',
              onTap: () => AppRoutes.navigateTo(context, AppRoutes.orders),
            ),
            ProfileMenuItem(
              icon: Icons.shopping_cart_outlined,
              title: 'My Cart',
              subtitle: '${cart.itemCount} items',
              onTap: () => AppRoutes.navigateTo(context, AppRoutes.cart),
            ),
            const SizedBox(height: 16),
            ProfileMenuItem(
              icon: Icons.headset_mic_outlined,
              title: 'Help & Support',
              onTap: () => AppRoutes.navigateTo(context, AppRoutes.support),
            ),
            ProfileMenuItem(
              icon: Icons.star_outline,
              title: 'Rate App',
              onTap: () => AppRoutes.navigateTo(context, AppRoutes.rate),
            ),
            ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => AppRoutes.navigateTo(context, AppRoutes.settings),
            ),

            // Logout Button
            if (user.isLoggedIn) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    user.logout();
                    AppRoutes.navigateAndClearStack(context, AppRoutes.welcome);
                  },
                  icon: const Icon(Icons.logout, color: AppTheme.errorColor),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: AppTheme.errorColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.errorColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 100), // Bottom padding for nav bar
          ],
        ),
      ),
    );
  }
}
