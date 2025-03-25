import 'package:equatable/equatable.dart';
import 'package:seddoapp/models/menumodels.dart';
import '../../models/CategorieModel.dart';
import '../../models/user_model.dart';

class HomeState extends Equatable {
  final int selectedTabIndex;
  final int currentNavigationIndex;
  final String currentCategory;
  final Map<String, List<MenuModels>> categoryPublications;
  final Map<String, List<MenuModels>> filteredPublications;
  final List<String> selectedTypes;
  final bool isLoading;
  final bool isFiltered;
  final String error;
  final UserModel? currentUser;
  final CategorieModel? selectedCategory; // CategorieModel pour la catégorie sélectionnée
  final bool isLoadingCategories; // État de chargement des catégories
  final List<CategorieModel> categories; // Liste des catégories

  HomeState({
    this.selectedTabIndex = 0,
    this.currentNavigationIndex = 0,
    this.currentCategory = 'All',
    this.categoryPublications = const {},
    this.filteredPublications = const {},
    this.selectedTypes = const [],
    this.selectedCategory,
    this.isLoading = false,
    this.isFiltered = false,
    this.error = '',
    this.currentUser,
    this.isLoadingCategories = false,
    this.categories = const [],
  });

  factory HomeState.initial() {
    return HomeState(
      selectedTabIndex: 0,
      currentNavigationIndex: 0,
      currentCategory: "Petit'dej\n",
      categoryPublications: {},
      filteredPublications: {},
      selectedTypes: [],
      isLoading: true,
      isFiltered: false,
      error: '',
      currentUser: null,
      isLoadingCategories: false,
      categories: [],
    );
  }

  HomeState copyWith({
    int? selectedTabIndex,
    int? currentNavigationIndex,
    String? currentCategory,
    Map<String, List<MenuModels>>? categoryPublications,
    Map<String, List<MenuModels>>? filteredPublications,
    List<String>? selectedTypes,
    CategorieModel? selectedCategory,
    bool? isLoading,
    bool? isFiltered,
    String? error,
    UserModel? currentUser,
    bool? isLoadingCategories,
    List<CategorieModel>? categories,
  }) {
    return HomeState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      currentNavigationIndex: currentNavigationIndex ?? this.currentNavigationIndex,
      currentCategory: currentCategory ?? this.currentCategory,
      categoryPublications: categoryPublications ?? this.categoryPublications,
      filteredPublications: filteredPublications ?? (isFiltered == false ? {} : this.filteredPublications),
      selectedTypes: selectedTypes ?? this.selectedTypes,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      isFiltered: isFiltered ?? this.isFiltered,
      error: error ?? this.error,
      currentUser: currentUser ?? this.currentUser,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    selectedTabIndex,
    currentNavigationIndex,
    currentCategory,
    categoryPublications,
    filteredPublications,
    selectedTypes,
    selectedCategory,
    isLoading,
    isFiltered,
    error,
    currentUser,
    isLoadingCategories,
    categories,
  ];
}
