class CourseModel {
  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final String? imageUrl;

  String get formattedPrice {
    final amount = price == price.roundToDouble()
        ? price.toStringAsFixed(0)
        : price.toStringAsFixed(2);
    return '$amount EGP';
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
    );
  }
}
