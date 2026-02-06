import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.iconPath,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      iconPath: json['iconPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'iconPath': iconPath};
  }
}
