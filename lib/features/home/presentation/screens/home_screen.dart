import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/widgets/glass_container.dart';
import 'package:bebsata/features/cart/presentation/providers/cart_provider.dart';
import 'package:bebsata/features/cart/presentation/screens/cart_screen.dart';
import 'package:bebsata/features/shop/presentation/providers/shop_provider.dart';
import 'package:bebsata/features/shop/presentation/widgets/product_card.dart';
import 'package:bebsata/features/shop/presentation/screens/product_details_screen.dart';
import 'package:bebsata/features/shop/presentation/screens/all_products_screen.dart';
import '../widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ShopProvider>(context, listen: false).loadShopData(),
    );
  }

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
                    AppTheme.primaryColor.withValues(alpha: 0.1),
                    AppTheme.accentColor.withValues(alpha: 0.05),
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, isDark),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: HomeSearchBar(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AllProductsScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Content
              Expanded(
                child: Consumer<ShopProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.error != null) {
                      return Center(child: Text(provider.error!));
                    }

                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        // Offer Banner
                        OfferBanner(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllProductsScreen(),
                              ),
                            );
                          },
                        ),

                        // Categories Section
                        const SectionHeader(title: 'Categories'),
                        const SizedBox(height: 16),
                        _buildCategoryList(provider),
                        const SizedBox(height: 24),

                        // Products Section
                        SectionHeader(
                          title: provider.selectedCategoryId == null
                              ? 'Popular Products'
                              : 'Products',
                          onSeeAll: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AllProductsScreen(
                                  categoryId: provider.selectedCategoryId,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Product Grid
                        _buildProductGrid(context, provider),

                        const SizedBox(height: 100), // Bottom padding
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Menu Button
          GlassContainer(
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Icon(Icons.menu_rounded),
            ),
          ),
          const SizedBox(width: 16),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Friend!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Find your needs',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          // Cart Button
          GlassContainer(
            borderRadius: BorderRadius.circular(50),
            padding: EdgeInsets.zero,
            child: IconButton(
              icon: Badge(
                isLabelVisible:
                    Provider.of<CartProvider>(context).itemCount > 0,
                label: Text('${Provider.of<CartProvider>(context).itemCount}'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(ShopProvider provider) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: provider.categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return CategoryItem(
              name: 'All',
              icon: Icons.apps,
              isSelected: provider.selectedCategoryId == null,
              onTap: () => provider.selectCategory(null),
            );
          }
          final category = provider.categories[index - 1];
          return CategoryItem(
            name: category.name,
            icon: _getCategoryIcon(index - 1),
            isSelected: provider.selectedCategoryId == category.id,
            onTap: () => provider.selectCategory(category.id),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, ShopProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: provider.filteredProducts.take(6).length,
      itemBuilder: (context, index) {
        final product = provider.filteredProducts[index];
        return ProductCard(
          product: product,
          isFavorite: provider.isFavorite(product.id),
          onFavorite: () => provider.toggleFavorite(product.id),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            );
          },
          onAddToCart: () {
            Provider.of<CartProvider>(
              context,
              listen: false,
            ).addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} added to cart'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.devices;
      case 1:
        return Icons.checkroom;
      case 2:
        return Icons.home_outlined;
      case 3:
        return Icons.sports_basketball;
      default:
        return Icons.category;
    }
  }
}
