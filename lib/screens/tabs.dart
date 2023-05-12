import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegan:false,
  Filter.vegetarian:false,
 };


class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
 
 int selectedPageIndex = 0;
 final List<Meal> favouriteMeals=[];
 Map<Filter, bool> _selectedFilters=kInitialFilters;

 void _showInfoMessage(String message){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message))
  );
 }

 void toggleMealFavouriteStatus(Meal meal){
  final isExisting=favouriteMeals.contains(meal);

  if (isExisting){
    setState(() {
  favouriteMeals.remove(meal);
});
_showInfoMessage("Meal removed from Favourites!");
  }
  else{
    setState(() {
  favouriteMeals.add(meal);
});
_showInfoMessage("Meal added to favourites");
  }
 }

 void _setScreen(String identifier) async {
  Navigator.of(context).pop();
  if(identifier=='filters'){
    final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,)));
  setState(() {
  _selectedFilters=result ?? kInitialFilters;
});
  }
 }

 void _selectPage(int index){
  setState(() {
    selectedPageIndex = index;
  });
 }
 
  @override
  Widget build(BuildContext context) {

    final availableMeals=dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
    
    Widget activePage=CategoriesScreen(onToggleFavourite: toggleMealFavouriteStatus, availableMeals: availableMeals,);
    var activePageTitle="Categories";

    if(selectedPageIndex == 1){
      activePage=MealsScreen(meals: favouriteMeals, onToggleFavourite: toggleMealFavouriteStatus,);
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