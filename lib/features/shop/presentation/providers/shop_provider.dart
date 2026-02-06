import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/shop_repository.dart';

class ShopProvider extends ChangeNotifier {
  final ShopRepository shopRepository;

  ShopProvider({required this.shopRepository});

  List<Product> _products = [];
  List<Product> _featuredProducts = [];
  List<Category> _categories = [];
  Set<String> _favoriteIds = {};
  String? _selectedCategoryId;
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  List<Product> get featuredProducts => _featuredProducts;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCategoryId => _selectedCategoryId;
  Set<String> get favoriteIds => _favoriteIds;

  // Filtered products by category
  List<Product> get filteredProducts {
    if (_selectedCategoryId == null) {
      return _products;
    }
    return _products.where((p) => p.categoryId == _selectedCategoryId).toList();
  }

  // Check if product is favorite
  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  // Toggle favorite
  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
  }

  // Clear all favorites
  void clearFavorites() {
    _favoriteIds.clear();
    notifyListeners();
  }

  // Select category
  void selectCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  Future<void> loadShopData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        shopRepository.getProducts(),
        shopRepository.getCategories(),
        shopRepository.getFeaturedProducts(),
      ]);

      _products = results[0] as List<Product>;
      _categories = results[1] as List<Category>;
      _featuredProducts = results[2] as List<Product>;
    } catch (e) {
      _error = 'Failed to load shop data';
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
