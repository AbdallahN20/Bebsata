import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

/// Profile header widget with avatar
class ProfileHeader extends StatelessWidget {
  final String name;
  final String? email;
  final bool isLoggedIn;
  final VoidCallback? onEditProfile;

  const ProfileHeader({
    super.key,
    required this.name,
    this.email,
    this.isLoggedIn = false,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar with gradient border
        GestureDetector(
          onTap: onEditProfile,
          child: Container(
            padding: const EdgeInsets.all(3),
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
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          email ?? (isLoggedIn ? '' : 'Sign in to access your profile'),
          style: TextStyle(color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}

/// Profile menu item widget
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = iconColor ?? AppTheme.primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              )
            : null,
        trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}

/// Profile stats card widget
class ProfileStatsCard extends StatelessWidget {
  final int ordersCount;
  final int favoritesCount;
  final int cartCount;
  final VoidCallback onOrdersTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onCartTap;

  const ProfileStatsCard({
    super.key,
    required this.ordersCount,
    required this.favoritesCount,
    required this.cartCount,
    required this.onOrdersTap,
    required this.onFavoritesTap,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Orders',
            count: ordersCount,
            onTap: onOrdersTap,
          ),
          _VerticalDivider(),
          _StatItem(
            icon: Icons.favorite_outline,
            label: 'Favorites',
            count: favoritesCount,
            color: Colors.red,
            onTap: onFavoritesTap,
          ),
          _VerticalDivider(),
          _StatItem(
            icon: Icons.shopping_cart_outlined,
            label: 'Cart',
            count: cartCount,
            onTap: onCartTap,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color? color;
  final VoidCallback onTap;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.count,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color ?? AppTheme.primaryColor, size: 24),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color ?? AppTheme.primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 40, width: 1, color: AppTheme.dividerColor);
  }
}
