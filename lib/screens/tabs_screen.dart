import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app4/providers/filters_provider.dart';
import 'package:app4/screens/meals_screen.dart';
import '../providers/favorites_prvider.dart';
import '../providers/nav_bar_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/main_darwer.dart';
import 'categories_screen.dart';
import 'filters_screen.dart';

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoriteMealsProvider);
    final availableMeals = ref.watch(filteredMealsProvider);
    final selectPageIndex = ref.watch(navBarProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Pick up your category';
    if (selectPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'filters') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const FiltersScreen(),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: ref.watch(navBarProvider.notifier).selectPage,
          currentIndex: selectPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
