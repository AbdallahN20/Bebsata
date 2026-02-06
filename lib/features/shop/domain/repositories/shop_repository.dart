import '../entities/category.dart';
import '../entities/product.dart';

abstract class ShopRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Category>> getCategories();
  Future<Product?> getProductById(String id);
  Future<List<Product>> getFeaturedProducts();
}
