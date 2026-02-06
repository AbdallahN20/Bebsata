import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/features/cart/presentation/providers/cart_provider.dart';
import 'package:bebsata/features/cart/presentation/screens/cart_screen.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/widgets/glass_container.dart';
import '../providers/shop_provider.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';
import 'all_products_screen.dart';

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
              // Custom App Bar / Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    // Menu Icon for Drawer
                    GlassContainer(
                      blur: 10,
                      opacity: 0.2,
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const Icon(Icons.menu_rounded),
                      ),
                    ),
                    const SizedBox(width: 16),
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
                    GlassContainer(
                      blur: 10,
                      opacity: 0.2,
                      borderRadius: BorderRadius.circular(50),
                      padding: EdgeInsets.zero,
                      child: IconButton(
                        icon: Badge(
                          isLabelVisible:
                              Provider.of<CartProvider>(context).itemCount > 0,
                          label: Text(
                            '${Provider.of<CartProvider>(context).itemCount}',
                          ),
                          child: const Icon(Icons.shopping_bag_outlined),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar with Glass Effect
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GlassContainer(
                  blur: 8,
                  opacity: 0.15,
                  padding: EdgeInsets.zero,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllProductsScreen(),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.textSecondary,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AllProductsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                  ),
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
                        // Offers Banner
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.offerColor,
                                AppTheme.offerColor.withValues(alpha: 0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.offerColor.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        '🔥 HOT DEAL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Up to 50% OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Limited time offer',
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Shop Now',
                                        style: TextStyle(
                                          color: AppTheme.offerColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.local_offer_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Categories Title
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Categories with Glass Effect
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.categories.length + 1,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // All Category
                                final isSelected =
                                    provider.selectedCategoryId == null;
                                return _buildCategoryItem(
                                  context,
                                  'All',
                                  Icons.apps,
                                  isSelected,
                                  () => provider.selectCategory(null),
                                );
                              }
                              final category = provider.categories[index - 1];
                              final isSelected =
                                  provider.selectedCategoryId == category.id;
                              return _buildCategoryItem(
                                context,
                                category.name,
                                _getCategoryIcon(index - 1),
                                isSelected,
                                () => provider.selectCategory(category.id),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Popular Products Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.selectedCategoryId == null
                                  ? 'Popular Products'
                                  : 'Products',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AllProductsScreen(
                                      categoryId: provider.selectedCategoryId,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See All',
                                    style: TextStyle(
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: AppTheme.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Product Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                              onFavorite: () =>
                                  provider.toggleFavorite(product.id),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsScreen(product: product),
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
                                    content: Text(
                                      '${product.name} added to cart',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ), // Bottom padding for nav bar
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

  Widget _buildCategoryItem(
    BuildContext context,
    String name,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                    )
                  : null,
              color: isSelected ? null : Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : Colors.white.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppTheme.primaryColor.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: isSelected ? 15 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : AppTheme.primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondary,
            ),
          ),
        ],
      ),
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
