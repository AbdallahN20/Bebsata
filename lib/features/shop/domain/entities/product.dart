class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFeatured = false,
  });
}
