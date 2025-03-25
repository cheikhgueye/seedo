import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seddoapp/models/menumodels.dart';
import 'package:seddoapp/services/menu_service.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/categorie_repository.dart';
import '../../services/CategorieService.dart';
import 'home_state.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MenuService _menuService = MenuService();
  final AuthRepository _authRepository = AuthRepository();
  final CategorieRepository _categorieRepository=CategorieRepository();

  HomeBloc() : super(HomeState.initial()) {
    on<InitializeHomeEvent>(_onInitializeHome);
    on<LoadCurrentUser>(_onLoadCurrentUser);
    on<TabChanged>(_onChangeTab);
    on<NavigationIndexChanged>(_onChangeNavigation);

    on<LoadCategories>(_onLoadCategories);
    on<SelectCategory>(_onSelectCategory);
    on<CategoryChanged>(_onCategoryChanged);

    on<TypesFilterChanged>(_onTypesFilterChanged);
    //on<CategoryFilterChanged>(_onCategoryFilterChanged);
    on<ApplyFilters>(_onApplyFilters);
    on<ResetFilters>(_onResetFilters);
    on<ToggleFavorite>(_onToggleFavorite);

    // Initialize data when bloc is created
    add(const InitializeHomeEvent());
  }

  Future<void> _onInitializeHome(
      InitializeHomeEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final categoryPublications = await _menuService.loadMenuData();

      if (categoryPublications.isEmpty) {
        emit(
          state.copyWith(isLoading: false, error: 'Failed to load menu data'),
        );
        return;
      }

      // Get first category if available
      final firstCategory =
      categoryPublications.keys.isNotEmpty
          ? categoryPublications.keys.first
          : "Petit'dej\n";

      emit(
        state.copyWith(
          categoryPublications: categoryPublications,
          currentCategory: firstCategory,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Error: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCurrentUser(
      LoadCurrentUser event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final user = await _authRepository.currentUser();
      if (user != null) {
        emit(state.copyWith(currentUser: user, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, error: 'Aucun utilisateur trouvé.'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Erreur de chargement utilisateur: ${e.toString()}'));
    }
  }

  void _onChangeTab(TabChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedTabIndex: event.tabIndex));
  }

  void _onChangeNavigation(
      NavigationIndexChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(state.copyWith(currentNavigationIndex: event.navigationIndex));
  }

 /* void _onChangeCategory(CategoryChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentCategory: event.category));
  }*/

  void _onTypesFilterChanged(
      TypesFilterChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(state.copyWith(selectedTypes: event.selectedTypes));
  }

  /*void _onCategoryFilterChanged(
      CategoryFilterChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }*/

  void _onApplyFilters(ApplyFilters event, Emitter<HomeState> emit) {
    try {
      // Create deep copy of category publications
      final Map<String, List<MenuModels>> filteredPublications = {};

      // Iterate through each category
      state.categoryPublications.forEach((category, menuItems) {
        List<MenuModels> filteredMenus = List.from(menuItems);

        // Apply type filtering if types are selected
        if (state.selectedTypes.isNotEmpty) {
          filteredMenus =
              filteredMenus.where((menu) {
                // Check if the menu's type is in the selected types list
                return state.selectedTypes.contains(menu.type);
              }).toList();
        }

        // Apply category filtering if a category is selected
        if (state.selectedCategory != null) {
          if (state.selectedCategory!.titre == 'Gratuits') {
            // Filter free items - this is just an example, adjust based on your model
            filteredMenus = filteredMenus
                .where(
                  (menu) =>
              menu.description.toLowerCase().contains('gratuit') ||
                  menu.type.toLowerCase().contains('gratuit'),
            )
                .toList();
          } else if (state.selectedCategory!.titre == 'Payants') {
            // Filter paid items
            filteredMenus = filteredMenus
                .where(
                  (menu) =>
              !menu.description.toLowerCase().contains('gratuit') &&
                  !menu.type.toLowerCase().contains('gratuit'),
            )
                .toList();
          }
        }

        // Only add the category if it has items after filtering
        if (filteredMenus.isNotEmpty) {
          filteredPublications[category] = filteredMenus;
        }
      });

      emit(
        state.copyWith(
          filteredPublications: filteredPublications,
          isFiltered: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Error applying filters: ${e.toString()}'));
    }
  }

  void _onResetFilters(ResetFilters event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        selectedTypes: [],
        selectedCategory: null, // Changed from empty string to null
        isFiltered: false,
        filteredPublications: {},
      ),
    );
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) {
    try {
      // Create a deep copy of categoryPublications with correct type
      final Map<String, List<MenuModels>> updatedPublications = {};

      // Properly copy the map with the correct types
      state.categoryPublications.forEach((category, menuList) {
        updatedPublications[category] = List<MenuModels>.from(menuList);
      });

      // Update the favorite status for all matching menu items across categories
      for (final category in updatedPublications.keys) {
        final menuList = updatedPublications[category]!;

        for (int i = 0; i < menuList.length; i++) {
          final menu = menuList[i];
          if (menu.title == event.menuId) {
            menuList[i] = menu.copyWith(isFavorite: !menu.isFavorite);
          }
        }
      }

      // If filtering is active, also update the filtered publications
      Map<String, List<MenuModels>>? updatedFilteredPublications;
      if (state.isFiltered) {
        updatedFilteredPublications = {};

        // Properly copy the filtered map with correct types
        state.filteredPublications.forEach((category, menuList) {
          updatedFilteredPublications![category] = List<MenuModels>.from(
            menuList,
          );
        });

        for (final category in updatedFilteredPublications.keys) {
          final menuList = updatedFilteredPublications[category]!;

          for (int i = 0; i < menuList.length; i++) {
            final menu = menuList[i];
            if (menu.title == event.menuId) {
              menuList[i] = menu.copyWith(isFavorite: !menu.isFavorite);
            }
          }
        }
      }

      emit(
        state.copyWith(
          categoryPublications: updatedPublications,
          filteredPublications: updatedFilteredPublications,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Error toggling favorite: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Charger les catégories via le service
      final categories = await _categorieRepository.fetchCategoriesNoParent() ;

      emit(state.copyWith(
        categories: categories,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Erreur de chargement des catégories: $e',
      ));
    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedCategory: event.category));
  }
}
