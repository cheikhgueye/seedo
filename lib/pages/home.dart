import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seddoapp/bloc/home/home_bloc.dart';
import 'package:seddoapp/bloc/home/home_event.dart';
import 'package:seddoapp/bloc/home/home_state.dart';
import 'package:seddoapp/pages/categories/categories.dart';
import 'package:seddoapp/pages/categories/category_filter_dialog.dart';
import 'package:seddoapp/pages/categories/details.dart';
import 'package:seddoapp/pages/categories/events.dart';
import 'package:seddoapp/models/menumodels.dart';
import 'package:seddoapp/pages/categories/types_filter_dialog.dart';

import '../widgets/home/CategoryDropdown.dart';
import '../widgets/home/UserNameSection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Créer un BlocProvider pour HomeBloc
    return BlocProvider(
      create:
          (context) =>
              HomeBloc()
                ..add(LoadCurrentUser())
                ..add(LoadCategories()),
      child: const _HomePageContent(),
    );
  }
}

// Separate stateless widget to use the provided HomeBloc
class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  static final tabIndicatorWidth = 120.0;

  @override
  Widget build(BuildContext context) {
    // Now we can safely access the HomeBloc from the context
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(251, 237, 237, 237),
          // Ajout de la barre de navigation fixe en bas
          bottomNavigationBar: _buildBottomNavigationBar(context, state),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // Main Yellow Header Block
                  _buildHeaderBlock(context, state),
                  // Contenu basé sur l'onglet sélectionné
                  state.selectedTabIndex == 0
                      ? _buildPublicationsContent(context, state)
                      : _buildMapContent(context, state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, HomeState state) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(251, 237, 237, 237),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.home, '', Colors.black, state),
          _buildNavItem(
            context,
            1,
            Icons.chat_bubble_outline,
            '',
            Colors.black,
            state,
          ),
          _buildNavItem(context, 2, Icons.grid_view, '', Colors.black, state),
          _buildNavItem(
            context,
            3,
            Icons.notifications_none_outlined,
            '',
            Colors.black,
            state,
          ),
          _buildNavItem(
            context,
            4,
            Icons.person_outline,
            '',
            Colors.black,
            state,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    Color color,
    HomeState state,
  ) {
    final isSelected = index == state.currentNavigationIndex;

    return InkWell(
      onTap: () {
        // Access the bloc from context
        context.read<HomeBloc>().add(
          NavigationIndexChanged(navigationIndex: index),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.orange : color, size: 28),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.orange : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBlock(BuildContext context, HomeState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 192, 5),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          // Top Row: Greeting, Notification, Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Greeting and Location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Hello, ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      UserNameSection(),
                      Container(
                        margin: const EdgeInsets.only(left: 116),
                        padding: const EdgeInsets.only(top: 0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/siren.png',
                              width: 30,
                              height: 30,
                              color: const Color.fromARGB(255, 203, 42, 31),
                            ),
                            const SizedBox(width: 16),
                            Image.asset(
                              'assets/icons/settings.png',
                              width: 26,
                              height: 26,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/location.png',
                        width: 16,
                        height: 16,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Medina, Dakar',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(width: 7),
                      Image.asset(
                        'assets/icons/arrow-down-sign-to-navigate.png',
                        width: 11,
                        height: 11,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Search Bara
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/loupe.png',
                  width: 26,
                  height: 26,
                  color: const Color.fromARGB(255, 55, 55, 55),
                ),
                const Expanded(child: SizedBox()),
                Image.asset(
                  'assets/icons/edit.png',
                  width: 24,
                  height: 24,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),

          // Navigation tabs avec animation
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tab Publications
                GestureDetector(
                  onTap: () {
                    context.read<HomeBloc>().add(const TabChanged(tabIndex: 0));
                  },
                  child: Column(
                    children: [
                      Text(
                        'Publications',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color:
                              state.selectedTabIndex == 0
                                  ? Colors.black
                                  : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab Map
                GestureDetector(
                  onTap: () {
                    context.read<HomeBloc>().add(const TabChanged(tabIndex: 1));
                  },
                  child: Column(
                    children: [
                      Text(
                        'Map',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color:
                              state.selectedTabIndex == 1
                                  ? Colors.black
                                  : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Barre de navigation animée
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(height: 2, color: Colors.transparent),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 2,
                width: tabIndicatorWidth,
                margin: EdgeInsets.only(
                  left:
                      state.selectedTabIndex == 0
                          ? 0
                          : MediaQuery.of(context).size.width -
                              1 * 2 -
                              tabIndicatorWidth -
                              1,
                ),
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildPublicationsContent(BuildContext context, HomeState state) {
    return Column(
      key: const ValueKey('publications'),
      children: [
        // Filter options - full width
        SizedBox(height: 15,),
        Container(
          //height: 50, // Set the height to ensure consistency for all elements
          width: double.infinity, // Take full width
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 13), // Add horizontal padding for space

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
            children: [
              // Category Dropdown
              Flexible(
                flex: 2, // Take up available space
                child: Container(
                  height: 50, // Ensure a consistent height for all containers
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CategoryDropdown(),
                ),
              ),
              SizedBox(width: 10), // Space between the widgets

              // Categories Filter (Clickable)
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    // Add your onTap functionality here
                  },
                  child: Container(
                    height: 50, // Same height as the others
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 218, 218),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the text and icon
                      children: [
                        Text(
                          'Tarif',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis, // Ensure no overflow
                          maxLines: 1, // Prevent wrapping
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Space between the widgets

              // Distance Filter (Clickable)
              Flexible(
                flex: 1,
                child: Container(
                  height: 50, // Same height as the others
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 210, 210, 210),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the text and icon
                    children: const [
                      Text(
                        '700m',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure no overflow
                        maxLines: 1, // Prevent wrapping
                      ),
                      Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Menu des catégories avec callback BLoC
        FoodCategoriesMenu(
          onCategoryChanged: (category) {
            // context.read<HomeBloc>().add(CategoryChanged(category: category));
          },
          currentCategory: state.currentCategory,
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Plats partagés',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              DetailPage(categoryName: state.currentCategory),
                    ),
                  );
                },
                child: const Text(
                  'Voir plus',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
        ),

        _buildPublicationsListContent(context, state),

        // FIX: Wrap EventsSection in a BlocProvider to provide HomeBloc
        BlocProvider.value(
          value: BlocProvider.of<HomeBloc>(context),
          child: const EventsSection(),
        ),
      ],
    );
  }

  Widget _buildPublicationsListContent(BuildContext context, HomeState state) {
    final publications = state.categoryPublications[state.currentCategory];

    if (publications == null || publications.isEmpty) {
      return const Center(
        child: Text(
          "Aucune publication disponible dans cette catégorie",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children:
                publications.map((menu) {
                  return Container(
                    width: 360,
                    height: 420,
                    margin: const EdgeInsets.only(left: 13, bottom: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section image
                          SizedBox(
                            height: 230,
                            child: _buildHorizontalImageSlider(menu),
                          ),

                          // Contenu détaillé
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 18,
                                right: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Titre avec bouton favori
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              menu.title,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Publié il y\'a ${menu.publishedTime}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                  255,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Icône du cœur
                                      IconButton(
                                        icon: Icon(
                                          menu.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 32,
                                          color:
                                              menu.isFavorite
                                                  ? Colors.red
                                                  : null,
                                        ),
                                        onPressed: () {
                                          context.read<HomeBloc>().add(
                                            ToggleFavorite(menuId: menu.title),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  // Catégorie, likes et emplacement
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Catégorie avec icône
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/tray-copie.png',
                                            width: 22,
                                            height: 22,
                                            color: Colors.black87,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            state.currentCategory.trim(),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                255,
                                                0,
                                                0,
                                                0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),

                                      // Likes
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/like.png',
                                            width: 22,
                                            height: 22,
                                            color: Colors.black87,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            '50 J\'aime',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                255,
                                                0,
                                                0,
                                                0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),

                                      // Emplacement
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/location.png',
                                              width: 22,
                                              height: 22,
                                              color: Colors.black87,
                                            ),
                                            const SizedBox(width: 4),
                                            const Flexible(
                                              child: Text(
                                                'Medina, Dakar',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),

                                  // Bouton de réservation
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          218,
                                          227,
                                          76,
                                          0,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 11,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Faire une réservation',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalImageSlider(MenuModels menu) {
    return SizedBox(
      height: 239,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              menu.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapContent(BuildContext context, HomeState state) {
    return Column(
      key: const ValueKey('map'),
      children: [
        Container(
          height: 500,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.map, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                "Carte des restaurants",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
