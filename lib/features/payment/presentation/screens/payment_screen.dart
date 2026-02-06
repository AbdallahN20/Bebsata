import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final String productName;

  const PaymentScreen({
    super.key,
    required this.amount,
    this.productName = 'Order',
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPayment = 0;
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isProcessing = false;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(name: 'Credit Card', icon: Icons.credit_card),
    PaymentMethod(name: 'PayPal', icon: Icons.account_balance_wallet),
    PaymentMethod(name: 'Cash on Delivery', icon: Icons.money),
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    setState(() => _isProcessing = true);

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isProcessing = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 60,
                color: AppTheme.successColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Payment Successful!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been placed successfully.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Total',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.productName,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Text(
                            '\$${widget.amount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Methods
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(_paymentMethods.length, (index) {
                    final method = _paymentMethods[index];
                    final isSelected = _selectedPayment == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () => setState(() => _selectedPayment = index),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : AppTheme.dividerColor,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: isSelected
                                ? AppTheme.primaryColor.withValues(alpha: 0.05)
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                method.icon,
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.textSecondary,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                method.name,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              const Spacer(),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppTheme.primaryColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Card Details (if credit card selected)
                  if (_selectedPayment == 0) ...[
                    Text(
                      'Card Details',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        hintText: '1234 5678 9012 3456',
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _expiryController,
                            decoration: const InputDecoration(
                              labelText: 'Expiry',
                              hintText: 'MM/YY',
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _cvvController,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              hintText: '123',
                            ),
                            keyboardType: TextInputType.number,
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Cardholder Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Pay Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text('Pay \$${widget.amount.toStringAsFixed(2)}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethod {
  final String name;
  final IconData icon;

  PaymentMethod({required this.name, required this.icon});
}
