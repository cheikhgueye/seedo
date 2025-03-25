class CategoriesModels {
  final String title;
  final String icon;
  bool isSelected;

  CategoriesModels({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });

  factory CategoriesModels.fromJson(Map<String, dynamic> map) {
    return CategoriesModels(
      title: map['title'],
      icon: map['icon'],
      isSelected: map['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'isSelected': isSelected,
    };
  }

  static List<CategoriesModels> fromJsonList(List<dynamic> list) {
    return list.map((item) => CategoriesModels.fromJson(item)).toList();
  }
}