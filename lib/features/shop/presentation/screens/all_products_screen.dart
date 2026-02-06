import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebsata/core/theme/app_theme.dart';
import 'package:bebsata/core/widgets/glass_container.dart';
import 'package:bebsata/features/cart/presentation/providers/cart_provider.dart';
import '../providers/shop_provider.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';

class AllProductsScreen extends StatefulWidget {
  final String? categoryId;
  final String? searchQuery;

  const AllProductsScreen({super.key, this.categoryId, this.searchQuery});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategoryId;
  String _sortBy = 'name';
  double _minPrice = 0;
  double _maxPrice = 1000;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.categoryId;
    _searchController.text = widget.searchQuery ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) {
    final provider = Provider.of<ShopProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _selectedCategoryId = null;
                            _sortBy = 'name';
                            _minPrice = 0;
                            _maxPrice = 1000;
                          });
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      // Categories
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFilterChip(
                            'All',
                            _selectedCategoryId == null,
                            () =>
                                setModalState(() => _selectedCategoryId = null),
                          ),
                          ...provider.categories.map(
                            (cat) => _buildFilterChip(
                              cat.name,
                              _selectedCategoryId == cat.id,
                              () => setModalState(
                                () => _selectedCategoryId = cat.id,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Sort By
                      Text(
                        'Sort By',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFilterChip(
                            'Name',
                            _sortBy == 'name',
                            () => setModalState(() => _sortBy = 'name'),
                          ),
                          _buildFilterChip(
                            'Price: Low to High',
                            _sortBy == 'price_asc',
                            () => setModalState(() => _sortBy = 'price_asc'),
                          ),
                          _buildFilterChip(
                            'Price: High to Low',
                            _sortBy == 'price_desc',
                            () => setModalState(() => _sortBy = 'price_desc'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Price Range
                      Text(
                        'Price Range',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${_minPrice.toInt()}'),
                          Text('\$${_maxPrice.toInt()}'),
                        ],
                      ),
                      RangeSlider(
                        values: RangeValues(_minPrice, _maxPrice),
                        min: 0,
                        max: 1000,
                        divisions: 20,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (values) {
                          setModalState(() {
                            _minPrice = values.start;
                            _maxPrice = values.end;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Apply Button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
            fontWeight: isSelected ? FontWeight.w600 : null,
          ),
        ),
      ),
    );
  }

  List<dynamic> _getFilteredProducts(ShopProvider provider) {
    var products = _selectedCategoryId == null
        ? provider.products
        : provider.products
              .where((p) => p.categoryId == _selectedCategoryId)
              .toList();

    // Search filter
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      products = products
          .where(
            (p) =>
                p.name.toLowerCase().contains(query) ||
                p.description.toLowerCase().contains(query),
          )
          .toList();
    }

    // Price filter
    products = products
        .where((p) => p.price >= _minPrice && p.price <= _maxPrice)
        .toList();

    // Sort
    switch (_sortBy) {
      case 'name':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'price_asc':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    return products;
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
              // App Bar with Back Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    GlassContainer(
                      blur: 10,
                      opacity: 0.2,
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _getTitle(context),
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GlassContainer(
                      blur: 10,
                      opacity: 0.2,
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () => _showFilterBottomSheet(context),
                        child: Badge(
                          isLabelVisible:
                              _selectedCategoryId != null ||
                              _sortBy != 'name' ||
                              _minPrice > 0 ||
                              _maxPrice < 1000,
                          child: const Icon(Icons.tune),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GlassContainer(
                  blur: 8,
                  opacity: 0.15,
                  padding: EdgeInsets.zero,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.textSecondary,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Products Grid
              Expanded(
                child: Consumer<ShopProvider>(
                  builder: (context, provider, _) {
                    final products = _getFilteredProducts(provider);

                    if (products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_basket_outlined,
                              size: 80,
                              color: AppTheme.textLight,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No products found',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: AppTheme.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedCategoryId = null;
                                  _searchController.clear();
                                  _minPrice = 0;
                                  _maxPrice = 1000;
                                });
                              },
                              child: const Text('Clear Filters'),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          product: product,
                          isFavorite: provider.isFavorite(product.id),
                          onFavorite: () => provider.toggleFavorite(product.id),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
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
                                content: Text('${product.name} added to cart'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        );
                      },
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

  String _getTitle(BuildContext context) {
    if (_selectedCategoryId == null) return 'All Products';
    final provider = Provider.of<ShopProvider>(context, listen: false);
    final category = provider.categories.firstWhere(
      (c) => c.id == _selectedCategoryId,
      orElse: () => provider.categories.first,
    );
    return category.name;
  }
}
