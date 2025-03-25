


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_state.dart';

class UserNameSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator()); // Afficher un indicateur de chargement
        } else if (state.currentUser != null) {
          // Si l'utilisateur est connecté, afficher son prénom
          return Text(
            '${state.currentUser?.firstName ?? 'Invité'}', // Utiliser firstName ou autre attribut de UserModel
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        } else {
          return const Text(
            'Bienvenue Invité',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ); // Si pas d'utilisateur connecté
        }
      },
    );
  }
}
