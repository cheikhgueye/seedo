import 'package:equatable/equatable.dart';
import '../../models/CategorieModel.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitializeHomeEvent extends HomeEvent {
  const InitializeHomeEvent();
}

class TabChanged extends HomeEvent {
  final int tabIndex;

  const TabChanged({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class ToggleFavorite extends HomeEvent {
  final String menuId; // Unique identifier for the menu item

  const ToggleFavorite({required this.menuId});

  @override
  List<Object> get props => [menuId];
}

class NavigationIndexChanged extends HomeEvent {
  final int navigationIndex;

  const NavigationIndexChanged({required this.navigationIndex});

  @override
  List<Object> get props => [navigationIndex];
}

class TypesFilterChanged extends HomeEvent {
  final List<String> selectedTypes;

  const TypesFilterChanged({required this.selectedTypes});

  @override
  List<Object> get props => [selectedTypes];
}

/*class CategoryFilterChanged extends HomeEvent {
  final CategorieModel? selectedCategory; // Changed from String to CategorieModel

  const CategoryFilterChanged({required this.selectedCategory});

  @override
  List<Object> get props => [selectedCategory];
}*/

class ApplyFilters extends HomeEvent {
  const ApplyFilters();
}

class ResetFilters extends HomeEvent {
  const ResetFilters();
}

class LoadCurrentUser extends HomeEvent {}


// Categorie events
class LoadCategories extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final CategorieModel category;

  const SelectCategory(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryChanged extends HomeEvent {
  final CategorieModel category;

  const CategoryChanged({required this.category});

  @override
  List<Object> get props => [category];
}
