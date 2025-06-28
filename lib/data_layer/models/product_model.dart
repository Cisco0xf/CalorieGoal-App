class ProductModel {
  final String name;
  final String imagePath;
  final int calories;
  int quantity;

  ProductModel({
    required this.calories,
    required this.imagePath,
    required this.name,
    this.quantity = 1,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      calories: json["calories"],
      imagePath: json["image_url"],
      name: json["food_name"],
    );
  }

  ProductModel copyWith({
    String? name,
    String? imagePath,
    int? calories,
    int? quantity,
  }) {
    return ProductModel(
      name: name ?? this.name,
      calories: calories ?? this.calories,
      imagePath: imagePath ?? this.imagePath,
      quantity: quantity ?? this.quantity,
    );
  }
}
