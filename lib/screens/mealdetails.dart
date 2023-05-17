import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final favouriteMeals = ref.watch(favouriteMealsProvider);
  final isFav = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: () {
            final wasAdded = ref.read(favouriteMealsProvider.notifier).toggleMealFavouriteStatus(meal);
             ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(wasAdded ? "Meal Added as a favourite" : "Meal removed from the favourites"))
  );
            }, icon: Icon(isFav ? Icons.star : Icons.star_border))
        ],
      ),
      body: 
      SingleChildScrollView(
        child: Column(children: [
          Image.network(
            meal.imageUrl,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            ),
            const SizedBox(height: 14,),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 14,),
              for(final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              )
                  ),
                  const SizedBox(height: 15,),
                  Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 14,),
              for(final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                            )
                    ),
                ),  
        ],
        ),
      ),
    );
  }
}