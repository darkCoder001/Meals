import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
 
 int selectedPageIndex = 0;

 void _setScreen(String identifier) async {
  Navigator.of(context).pop();
  if(identifier=='filters'){
    await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) =>const  FiltersScreen()));
  }
 }

 void _selectPage(int index){
  setState(() {
    selectedPageIndex = index;
  });
 }
 
  @override
  Widget build(BuildContext context) {
    
    final meals = ref.watch(mealsProvider); 

    final activeFilters = ref.watch(filtersProvider);

    final availableMeals=meals.where((meal) {
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
    
    Widget activePage=CategoriesScreen(availableMeals: availableMeals,);
    var activePageTitle="Categories";

    if(selectedPageIndex == 1){
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage=MealsScreen(meals: favouriteMeals,);
      activePageTitle="Your Favourites";
    }

    
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
            )
        ],
      ),
    );
  }
}