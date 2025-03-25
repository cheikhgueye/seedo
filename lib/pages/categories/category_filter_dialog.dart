// Create a new file: category_filter_dialog.dart
import 'package:flutter/material.dart';

class CategoryFilterDialog extends StatefulWidget {
  final List<String> availableCategories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilterDialog({
    super.key,
    required this.availableCategories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryFilterDialogState createState() => _CategoryFilterDialogState();
}

class _CategoryFilterDialogState extends State<CategoryFilterDialog> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Explorez les catégories qui vous intéressent !',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Radio buttons for single selection
            ...widget.availableCategories.map((category) {
              return RadioListTile<String>(
                title: Text(category),
                value: category,
                groupValue: _selectedCategory,
                activeColor: Colors.orange,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              );
              // ignore: unnecessary_to_list_in_spreads
            }).toList(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onCategorySelected(_selectedCategory);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD07A3B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Choisir',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
