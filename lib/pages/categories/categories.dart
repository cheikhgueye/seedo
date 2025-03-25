import 'package:flutter/material.dart';

import '../../models/categoriesmodels.dart';

class FoodCategoriesMenu extends StatefulWidget {
  final Function(String)? onCategoryChanged;
  final String currentCategory;

  const FoodCategoriesMenu({
    super.key,
    this.onCategoryChanged,
    required this.currentCategory,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FoodCategoriesMenuState createState() => _FoodCategoriesMenuState();
}

class _FoodCategoriesMenuState extends State<FoodCategoriesMenu> {
  late List<CategoriesModels> categories;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    // Initialiser les catégories
    categories = [
      CategoriesModels(
        title: "Petit'dej\n",
        icon: 'assets/icons/breakfast.png',
        isSelected: widget.currentCategory == "Petit'dej\n",
      ),
      CategoriesModels(
        title: "Déjeuner\n",
        icon: 'assets/icons/noodle.png',
        isSelected: widget.currentCategory == "Déjeuner\n",
      ),
      CategoriesModels(
        title: "Snacks\n",
        icon: 'assets/icons/snacks.png',
        isSelected: widget.currentCategory == "Snacks\n",
      ),
      CategoriesModels(
        title: "Fruits\n& Legumes",
        icon: 'assets/icons/groceries.png',
        isSelected: widget.currentCategory == "Fruits\n& Legumes",
      ),
      CategoriesModels(
        title: "Boissons\n& Jus",
        icon: 'assets/icons/juice.png',
        isSelected: widget.currentCategory == "Boissons\n& Jus",
      ),
    ];

    // Trouver l'index de la catégorie actuelle
    _selectedIndex = categories.indexWhere(
      (category) => category.title == widget.currentCategory,
    );
    if (_selectedIndex == -1) {
      _selectedIndex = 0; // Défaut à Déjeuner si non trouvé
    }
  }

  @override
  void didUpdateWidget(FoodCategoriesMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mettre à jour la sélection si la catégorie actuelle change depuis le parent
    if (widget.currentCategory != oldWidget.currentCategory) {
      updateSelectedCategory();
    }
  }

  void updateSelectedCategory() {
    final newIndex = categories.indexWhere(
      (category) => category.title == widget.currentCategory,
    );
    if (newIndex != -1 && newIndex != _selectedIndex) {
      setState(() {
        // Réinitialiser les sélections
        for (var category in categories) {
          category.isSelected = false;
        }
        // Marquer la nouvelle catégorie comme sélectionnée
        categories[newIndex].isSelected = true;
        _selectedIndex = newIndex;
      });
    }
  }

  void _selectCategory(int index) {
    if (_selectedIndex == index) return; // Ne rien faire si déjà sélectionné

    setState(() {
      // Désélectionner toutes les catégories
      for (var category in categories) {
        category.isSelected = false;
      }
      // Sélectionner la catégorie cliquée
      categories[index].isSelected = true;
      _selectedIndex = index;
    });

    // Notifier le parent du changement de catégorie
    if (widget.onCategoryChanged != null) {
      widget.onCategoryChanged!(categories[index].title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              categories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;
                return GestureDetector(
                  onTap: () => _selectCategory(index), // Gestion du clic
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 80,
                    child: Column(
                      children: [
                        // Cercle contenant l'icône
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 60),
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color:
                                category.isSelected
                                    ? Colors
                                        .white // Fond blanc si sélectionné
                                    : null,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              category.icon,
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                ); // Fallback si l'image ne charge pas
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Titre de la catégorie
                        Text(
                          category.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
