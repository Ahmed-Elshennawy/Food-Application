import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);

  bool toggleMealFavoritestatus(Meal meal) {
    var isExisting = state.contains(meal);
    if (isExisting) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>(
  (_) {
    return FavoritesMealsNotifier();
  },
);
