import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';// to use riverpod package
import 'package:meals_animation/provider/favorites_provider.dart';
import 'package:meals_animation/screens/categories_screen.dart';
import 'package:meals_animation/screens/filter_screen.dart';
import 'package:meals_animation/screens/meals_screen.dart';
import 'package:meals_animation/widgets/main_drawer.dart';
import 'package:meals_animation/provider/filter_provider.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget { //addition of Consumer is due to riverpod package
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  

  

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
       await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) =>  const FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  final availableMeals = ref.watch(filterMealProvider);

    Widget activePage =
        CategoriesScreen(availableMeals: availableMeals);
    var activeTitlePage = 'Your Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activeTitlePage = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitlePage),
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            )
          ]),
    );
  }
}
