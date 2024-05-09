import 'package:flutter/material.dart';
import 'package:meals_animation/data/dummy_data.dart';
import 'package:meals_animation/screens/meals_screen.dart';
import 'package:meals_animation/widgets/category_grid_item.dart';
import 'package:meals_animation/models/category.dart';
import 'package:meals_animation/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availableMeals});


  final List<Meal> availableMeals;

// here we created _selectedCategory method to connet CategoriesScreen and MealsScreen
  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // it is a condition to filter out the id in categories related to id in dummy meals if it matches it will store into the variable
    // here we are writing BuildContext context inside function because in stateless widgets context is not available globally
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context,route)  both are same , here route is created using MaterialPageRoute class.
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category))
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              onSelectedCategory: () {
                _selectedCategory(context, category);
              })
      ],
    );
  }
}
