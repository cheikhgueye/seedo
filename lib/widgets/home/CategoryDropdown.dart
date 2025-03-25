import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../models/CategorieModel.dart';

class CategoryDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DropdownButton<CategorieModel>(
          isExpanded: true,
          value: state.selectedCategory,
          onChanged: (CategorieModel? newCategory) {
            if (newCategory != null) {
              context.read<HomeBloc>().add(
                CategoryChanged(category: newCategory),
              );
            }
          },
          icon: Icon(Icons.keyboard_arrow_down, size: 20),
          hint: Text(
            'Categorie principale',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          underline: SizedBox.shrink(),
          items:
              state.categories.map<DropdownMenuItem<CategorieModel>>((
                CategorieModel category,
              ) {
                return DropdownMenuItem<CategorieModel>(
                  value: category,
                  child: Text(category.titre, style: TextStyle(fontSize: 12)),
                );
              }).toList(),
        );
      },
    );
  }
}
