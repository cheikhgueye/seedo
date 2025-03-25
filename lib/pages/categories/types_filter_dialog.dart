// Create a new file: types_filter_dialog.dart
import 'package:flutter/material.dart';

class TypesFilterDialog extends StatefulWidget {
  final List<String> availableTypes;
  final List<String> selectedTypes;
  final Function(List<String>) onTypesSelected;

  const TypesFilterDialog({
    super.key,
    required this.availableTypes,
    required this.selectedTypes,
    required this.onTypesSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TypesFilterDialogState createState() => _TypesFilterDialogState();
}

class _TypesFilterDialogState extends State<TypesFilterDialog> {
  late List<String> _selectedTypes;

  @override
  void initState() {
    super.initState();
    _selectedTypes = List.from(widget.selectedTypes);
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
                  'Découvrez ce qui vous intéresse !',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Choisissez un type de publication :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            // List of checkboxes for multiple selection
            ...widget.availableTypes.map((type) {
              return CheckboxListTile(
                title: Text(type),
                value: _selectedTypes.contains(type),
                activeColor: Colors.orange,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected == true) {
                      _selectedTypes.add(type);
                    } else {
                      _selectedTypes.remove(type);
                    }
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
                  widget.onTypesSelected(_selectedTypes);
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
