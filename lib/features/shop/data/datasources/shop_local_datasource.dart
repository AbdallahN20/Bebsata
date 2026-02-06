import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class ShopLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
}

class ShopLocalDataSourceImpl implements ShopLocalDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    // Mock Data
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const CategoryModel(
        id: '1',
        name: 'Electronics',
        iconPath: 'assets/icons/electronics.png',
      ),
      const CategoryModel(
        id: '2',
        name: 'Fashion',
        iconPath: 'assets/icons/fashion.png',
      ),
      const CategoryModel(
        id: '3',
        name: 'Home',
        iconPath: 'assets/icons/home.png',
      ),
      const CategoryModel(
        id: '4',
        name: 'Sports',
        iconPath: 'assets/icons/sports.png',
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    // Mock Data simulating a professional market
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      const ProductModel(
        id: '101',
        name: 'Wireless Noise Cancelling Headphones',
        description:
            'Premium sound quality with active noise cancellation and 30-hour battery life.',
        price: 299.99,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000&auto=format&fit=crop',
        categoryId: '1',
        rating: 4.8,
        reviewCount: 120,
        isFeatured: true,
      ),
      const ProductModel(
        id: '102',
        name: 'Smart Watch Series 7',
        description:
            'Advanced fitness tracking, ECG app, and always-on Retina display.',
        price: 399.00,
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop',
        categoryId: '1',
        rating: 4.9,
        reviewCount: 85,
        isFeatured: true,
      ),
      const ProductModel(
        id: '201',
        name: 'Men\'s Classic Leather Jacket',
        description:
            'Genuine leather jacket with a modern fit and durable construction.',
        price: 149.50,
        imageUrl:
            'https://images.unsplash.com/photo-1551028919-ac66e6a39d7e?q=80&w=1000&auto=format&fit=crop',
        categoryId: '2',
        rating: 4.5,
        reviewCount: 45,
        isFeatured: false,
      ),
      const ProductModel(
        id: '202',
        name: 'Women\'s Running Sneakers',
        description:
            'Lightweight and breathable design perfect for daily runs.',
        price: 89.99,
        imageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1000&auto=format&fit=crop',
        categoryId: '2',
        rating: 4.7,
        reviewCount: 200,
        isFeatured: true,
      ),
      const ProductModel(
        id: '301',
        name: 'Modern Minimalist Lamp',
        description:
            'Sleek design that fits perfectly in any contemporary living room.',
        price: 45.00,
        imageUrl:
            'https://images.unsplash.com/photo-1507473888900-52e1adad54cd?q=80&w=1000&auto=format&fit=crop',
        categoryId: '3',
        rating: 4.2,
        reviewCount: 30,
        isFeatured: false,
      ),
      const ProductModel(
        id: '401',
        name: 'Professional Tennis Racket',
        description: 'Graphite composite frame for power and control.',
        price: 129.99,
        imageUrl:
            'https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?q=80&w=1000&auto=format&fit=crop',
        categoryId: '4',
        rating: 4.6,
        reviewCount: 15,
        isFeatured: false,
      ),
    ];
  }
}
