import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/widgets/animated_heart.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: Colors.grey[100],
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (product.isFeatured)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.primaryColor,
                                    AppTheme.accentColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'FEATURED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        // Animated Heart in corner
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: AnimatedHeart(
                              isFavorite: isFavorite,
                              onTap: onFavorite ?? () {},
                              size: 20,
                              activeColor: Colors.red,
                              inactiveColor: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Details Section
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(height: 1.2, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.rating.toString(),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${product.reviewCount})',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppTheme.textLight),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                            InkWell(
                              onTap: onAddToCart,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor,
                                      AppTheme.primaryDark,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
