import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/features/payment/presentation/screens/payment_screen.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  final bool showBackButton;

  const CartScreen({super.key, this.showBackButton = true});

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
                    AppTheme.secondaryColor.withValues(alpha: 0.05),
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    // Back Button - Only show when navigated to (not as tab)
                    if (showBackButton)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppTheme.glassDark.withValues(alpha: 0.8)
                                    : AppTheme.glassLight.withValues(
                                        alpha: 0.8,
                                      ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Colors.grey.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Text(
                      'Shopping Cart',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    Consumer<CartProvider>(
                      builder: (context, cart, _) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppTheme.glassDark.withValues(alpha: 0.8)
                              : AppTheme.glassLight.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          '${cart.itemCount} items',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Cart Items
              Expanded(
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    if (cart.items.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppTheme.glassDark.withValues(alpha: 0.5)
                                    : AppTheme.glassLight.withValues(
                                        alpha: 0.8,
                                      ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 60,
                                color: AppTheme.primaryColor.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Your cart is empty',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: isDark
                                        ? AppTheme.darkTextSecondary
                                        : AppTheme.textSecondary,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add items to start shopping',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(24),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkSurface : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.2),
                            ),
                            boxShadow: isDark
                                ? null
                                : [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                          ),
                          child: Row(
                            children: [
                              // Image
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: isDark
                                      ? Colors.grey[800]
                                      : Colors.grey[100],
                                  image: DecorationImage(
                                    image: NetworkImage(item.product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${item.product.price.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: AppTheme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              // Quantity Actions
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 18),
                                      onPressed: () {
                                        cart.updateQuantity(
                                          item.product.id,
                                          item.quantity - 1,
                                        );
                                      },
                                      color: AppTheme.primaryColor,
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 18),
                                      onPressed: () {
                                        cart.updateQuantity(
                                          item.product.id,
                                          item.quantity + 1,
                                        );
                                      },
                                      color: AppTheme.primaryColor,
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Total Checkout
              Consumer<CartProvider>(
                builder: (context, cart, _) {
                  if (cart.items.isEmpty) return const SizedBox();
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkSurface : Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PaymentScreen(
                                    amount: cart.totalAmount,
                                    productName: '${cart.itemCount} items',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Proceed to Checkout'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
