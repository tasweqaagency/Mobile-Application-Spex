class CategoryModel {
  final int id;
  final String name;
  final String imagePath;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imagePath: json['image']?['src'] ?? '',
      productCount: json['count'] ?? 0,
    );
  }
}
