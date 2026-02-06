import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.categoryId,
    super.rating,
    super.reviewCount,
    super.isFeatured,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      categoryId: json['categoryId'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'rating': rating,
      'reviewCount': reviewCount,
      'isFeatured': isFeatured,
    };
  }
}
