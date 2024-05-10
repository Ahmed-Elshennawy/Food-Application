import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.9,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              availableMeals: widget.availableMeals,
            ),
        ],
      ),
      builder: (ctx, child) => SlideTransition(
        position: _controller.drive(
          Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ),
        ),
        child: child,
      ),
    );
  }
}
