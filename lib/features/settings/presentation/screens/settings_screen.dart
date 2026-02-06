import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _buildSectionTitle(context, 'Appearance'),
          _buildSettingCard(
            context,
            children: [
              ListTile(
                leading: Icon(
                  theme.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: AppTheme.primaryColor,
                ),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: theme.isDarkMode,
                  onChanged: (_) => theme.toggleTheme(),
                  activeColor: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notifications Section
          _buildSectionTitle(context, 'Notifications'),
          _buildSettingCard(
            context,
            children: [
              _buildSwitchTile('Push Notifications', true, (_) {}),
              const Divider(height: 1),
              _buildSwitchTile('Email Notifications', false, (_) {}),
              const Divider(height: 1),
              _buildSwitchTile('Order Updates', true, (_) {}),
              const Divider(height: 1),
              _buildSwitchTile('Promotional Offers', false, (_) {}),
            ],
          ),
          const SizedBox(height: 24),

          // Privacy Section
          _buildSectionTitle(context, 'Privacy'),
          _buildSettingCard(
            context,
            children: [
              _buildNavigationTile(
                context,
                'Privacy Policy',
                Icons.privacy_tip_outlined,
              ),
              const Divider(height: 1),
              _buildNavigationTile(
                context,
                'Terms of Service',
                Icons.description_outlined,
              ),
              const Divider(height: 1),
              _buildNavigationTile(
                context,
                'Data & Privacy',
                Icons.security_outlined,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // About Section
          _buildSectionTitle(context, 'About'),
          _buildSettingCard(
            context,
            children: [
              ListTile(
                leading: Icon(Icons.info_outline, color: AppTheme.primaryColor),
                title: const Text('App Version'),
                trailing: Text(
                  '1.0.0',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Divider(height: 1),
              _buildNavigationTile(context, 'Licenses', Icons.article_outlined),
            ],
          ),
          const SizedBox(height: 32),

          // Danger Zone
          _buildSectionTitle(context, 'Danger Zone'),
          _buildSettingCard(
            context,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: AppTheme.errorColor,
                ),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(color: AppTheme.errorColor),
                ),
                onTap: () => _showDeleteDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppTheme.textSecondary),
      ),
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Card(child: Column(children: children));
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {},
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle delete
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
