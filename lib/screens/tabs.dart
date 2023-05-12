import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
 
 int selectedPageIndex = 0;

 final List<Meal> favouriteMeals=[];

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

 void _setScreen(String identifier){
  if(identifier=='filters'){

  }
  else{
    Navigator.of(context).pop();
  }
 }

 void _selectPage(int index){
  setState(() {
    selectedPageIndex = index;
  });
 }
 
  @override
  Widget build(BuildContext context) {
    
    Widget activePage=CategoriesScreen(onToggleFavourite: toggleMealFavouriteStatus,);
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