import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/mealdetails.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, this.title});
  
  final String? title;
  final List<Meal> meals;

  void selectMeal(Meal meal, BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    
    Widget content =  ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(meal: meals[index], onSelectMeal: selectMeal,));

    if(meals.isEmpty){
      content=Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uh Oh...Nothing here!",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),
              ),
            const SizedBox(height: 16,),
            Text(
              "Try Selecting a different category!", 
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),
              )
        ]),
      );
    }

    if(title==null){
      return content;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!
        ),
      ),
      body: content,
    );
  }
}