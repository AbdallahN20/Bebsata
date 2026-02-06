import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/features/user/presentation/providers/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    if (name.isNotEmpty && email.isNotEmpty && _agreeTerms) {
      Provider.of<UserProvider>(context, listen: false).login(name, email);
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Create\nAccount',
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(height: 1.2),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to start shopping',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
              // Name Field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Email Field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppTheme.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Terms Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                    activeColor: AppTheme.primaryColor,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: AppTheme.primaryColor),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _agreeTerms ? _signUp : null,
                  child: const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 32),
              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
