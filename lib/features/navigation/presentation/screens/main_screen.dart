import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bebsata/features/shop/presentation/screens/home_screen.dart';
import 'package:bebsata/features/cart/presentation/screens/cart_screen.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/widgets/app_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(showBackButton: false),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: const AppDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildGlassNavBar(),
    );
  }

  Widget _buildGlassNavBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.glassDark.withValues(alpha: 0.9)
                  : AppTheme.glassLight.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.shopping_bag_rounded, 'Cart'),
                _buildNavItem(2, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondary,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppTheme.primaryColor.withValues(alpha: 0.15),
                    AppTheme.darkBackground,
                  ]
                : [
                    AppTheme.primaryColor.withValues(alpha: 0.08),
                    AppTheme.accentColor.withValues(alpha: 0.05),
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.accentColor],
                    ),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).cardColor,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Guest User',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sign in to access your profile',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/welcome');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildMenuItem(context, Icons.favorite_outline, 'My Favorites'),
                _buildMenuItem(
                  context,
                  Icons.local_shipping_outlined,
                  'My Orders',
                  () => Navigator.pushNamed(context, '/orders'),
                ),
                _buildMenuItem(
                  context,
                  Icons.location_on_outlined,
                  'Delivery Address',
                ),
                _buildMenuItem(
                  context,
                  Icons.payment_outlined,
                  'Payment Methods',
                ),
                _buildMenuItem(
                  context,
                  Icons.settings_outlined,
                  'Settings',
                  () => Navigator.pushNamed(context, '/settings'),
                ),
                _buildMenuItem(
                  context,
                  Icons.help_outline,
                  'Help & Support',
                  () => Navigator.pushNamed(context, '/support'),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, [
    VoidCallback? onTap,
  ]) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.glassDark.withValues(alpha: 0.8)
            : AppTheme.glassLight.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        onTap: onTap ?? () {},
      ),
    );
  }
}
