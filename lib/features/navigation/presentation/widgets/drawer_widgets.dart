import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

/// Drawer header widget with user info
class AppDrawerHeader extends StatelessWidget {
  final String name;
  final String? email;
  final VoidCallback onTap;

  const AppDrawerHeader({
    super.key,
    required this.name,
    this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Icon(Icons.edit, color: Colors.white.withValues(alpha: 0.7)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              email ?? 'Tap to view profile',
              style: TextStyle(
                color: Colors.white.withValues(
                  alpha: email != null ? 0.8 : 0.7,
                ),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Drawer menu item widget
class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

/// Theme toggle tile widget
class DrawerThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const DrawerThemeToggle({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: AppTheme.primaryColor,
      ),
      title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
      trailing: Switch(
        value: isDark,
        onChanged: (_) => onToggle(),
        activeColor: AppTheme.primaryColor,
      ),
      onTap: onToggle,
    );
  }
}

/// Quick action button widget
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}

/// Logout button widget
class DrawerLogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const DrawerLogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onLogout,
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
    );
  }
}
