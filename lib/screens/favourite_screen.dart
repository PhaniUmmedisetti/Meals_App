import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen(List<Meal> favouriteMeals);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  Text('Favourites'),
    );
  }
}
