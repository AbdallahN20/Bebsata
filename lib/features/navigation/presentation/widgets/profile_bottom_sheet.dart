import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/routes/app_routes.dart';
import 'package:bebsata/features/user/presentation/providers/user_provider.dart';
import 'drawer_widgets.dart';

/// Profile bottom sheet widget
class ProfileBottomSheet extends StatelessWidget {
  final UserProvider user;

  const ProfileBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
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
              child: Icon(Icons.person, size: 50, color: AppTheme.primaryColor),
            ),
          ),
          const SizedBox(height: 16),

          // Name & Email
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
                QuickActionButton(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Orders',
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.navigateTo(context, AppRoutes.orders);
                  },
                ),
                QuickActionButton(
                  icon: Icons.favorite_outline,
                  label: 'Favorites',
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.navigateTo(context, AppRoutes.favorites);
                  },
                ),
                QuickActionButton(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.navigateTo(context, AppRoutes.settings);
                  },
                ),
              ],
            ),
          ),
          const Spacer(),

          // Sign In button
          if (!user.isLoggedIn)
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    AppRoutes.navigateTo(context, AppRoutes.welcome);
                  },
                  child: const Text('Sign In'),
                ),
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
