import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

   

   final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category){
    final filteredMeals=availableMeals.where((meal) => meal.categories.contains(category.id)).toList();
    
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        meals: filteredMeals, 
        title: category.title,
        )
        )
        );
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20 
            ),
          children: [
            for(final category in availableCategories)
              CategoryGridItem(category: category, onSelectCategory: () {
                _selectCategory(context, category);
              },)    
        ],  
      ),
    );
  }
}