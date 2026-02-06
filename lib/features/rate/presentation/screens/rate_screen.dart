import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  int _rating = 0;
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitRating() {
    if (_rating > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate App')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.star_rounded,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Enjoying Bebsata?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We would love to hear your feedback!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = index + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index < _rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 48,
                      color: index < _rating
                          ? Colors.amber
                          : AppTheme.textSecondary,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              _getRatingText(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.primaryColor),
            ),
            const SizedBox(height: 32),
            // Feedback Text
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tell us more (optional)...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _rating > 0 ? _submitRating : null,
                child: const Text('Submit Rating'),
              ),
            ),
            const SizedBox(height: 16),
            // Maybe Later
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Maybe Later'),
            ),
          ],
        ),
      ),
    );
  }

  String _getRatingText() {
    switch (_rating) {
      case 1:
        return 'Poor 😞';
      case 2:
        return 'Fair 😐';
      case 3:
        return 'Good 🙂';
      case 4:
        return 'Great 😊';
      case 5:
        return 'Excellent! 🤩';
      default:
        return 'Tap a star to rate';
    }
  }
}
