import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
 
 int selectedPageIndex = 0;

 void _selectPage(int index){
  setState(() {
    selectedPageIndex = index;
  });
 }
 
  @override
  Widget build(BuildContext context) {
    
    Widget activePage=CategoriesScreen();
    var activePageTitle="Categories";

    if(selectedPageIndex == 1){
      activePage=MealsScreen(meals: []);
      activePageTitle="Your Favourites";
    }

    
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
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