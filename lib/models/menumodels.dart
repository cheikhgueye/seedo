class MenuModels {
  final String title;
  final String restaurant;
  final String description;
  final String image;
  final String publishedTime;
  final String distance;
  final String type;
  final bool isFavorite;

  const MenuModels({
    required this.title,
    required this.restaurant,
    required this.description,
    required this.image,
    required this.publishedTime,
    required this.distance,
    this.isFavorite = false,
    required this.type,
  });

  factory MenuModels.fromJson(Map<String, dynamic> map) {
    return MenuModels(
      title: map['title'] ?? '',
      restaurant: map['restaurant'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      publishedTime: map['publishedTime'] ?? '',
      distance: map['distance'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'restaurant': restaurant,
      'description': description,
      'image': image,
      'publishedTime': publishedTime,
      'distance': distance,
      'isFavorite': isFavorite,
      'type': type,
    };
  }

  // Add copyWith method for immutability
  MenuModels copyWith({
    String? title,
    String? restaurant,
    String? description,
    String? image,
    String? publishedTime,
    String? distance,
    String? type,
    bool? isFavorite,
  }) {
    return MenuModels(
      title: title ?? this.title,
      restaurant: restaurant ?? this.restaurant,
      description: description ?? this.description,
      image: image ?? this.image,
      publishedTime: publishedTime ?? this.publishedTime,
      distance: distance ?? this.distance,
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  static List<MenuModels> fromJsonList(List<dynamic> list) {
    return list.map((item) => MenuModels.fromJson(item)).toList();
  }

  @override
  String toString() {
    return 'MenuModels(title: $title, restaurant: $restaurant, type: $type, isFavorite: $isFavorite)';
  }
}
