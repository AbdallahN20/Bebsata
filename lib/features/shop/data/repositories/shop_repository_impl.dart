import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_local_datasource.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopLocalDataSource localDataSource;

  ShopRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Category>> getCategories() async {
    return await localDataSource.getCategories();
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    final products = await localDataSource.getProducts();
    return products.where((p) => p.isFeatured).toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    final products = await localDataSource.getProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    return await localDataSource.getProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final products = await localDataSource.getProducts();
    return products.where((p) => p.categoryId == categoryId).toList();
  }
}
