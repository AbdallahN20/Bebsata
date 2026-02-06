import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/features/cart/presentation/providers/cart_provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/widgets/glass_container.dart';
import '../../domain/entities/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassContainer(
            blur: 10,
            opacity: 0.3,
            borderRadius: BorderRadius.circular(12),
            padding: EdgeInsets.zero,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassContainer(
              blur: 10,
              opacity: 0.3,
              borderRadius: BorderRadius.circular(12),
              padding: EdgeInsets.zero,
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: AppTheme.secondaryColor,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                Provider.of<CartProvider>(
                                  context,
                                  listen: false,
                                ).removeFromCart(product.id);
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppTheme.primaryColor.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              Hero(
                tag: product.id,
                child: Container(
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        GlassContainer(
                          blur: 8,
                          opacity: 0.15,
                          borderRadius: BorderRadius.circular(12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber[600],
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.rating.toString(),
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${product.reviewCount} reviews',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description Card with Glass Effect
                    GlassContainer(
                      blur: 10,
                      opacity: 0.1,
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppTheme.textSecondary,
                                  height: 1.6,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
