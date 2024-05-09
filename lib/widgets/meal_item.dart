import 'package:flutter/material.dart';
import 'package:meals_animation/models/meal.dart';
import 'package:meals_animation/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.onSelectedMeal});

  final Meal meal;

  final void Function(BuildContext context,Meal meal) onSelectedMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // for fixed widgets
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip
          .hardEdge, // which cuts the image out of shape , this is due to stack forces the shape to non cutable
      elevation: 3,
      child: InkWell(
        // to make child widgets tappable
        onTap: () {
          onSelectedMeal(context, meal);
        },
        child: Stack(
          // which places widgets one above the other
          children: [
            FadeInImage(
              // which will show the memoryImage untill the networkimage get loaded in a transparentway
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, // if the text overflows then it replaced with ...
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min'),
                    const SizedBox(width: 12,),
                     MealItemTrait(icon: Icons.work, label: complexityText),
                    const SizedBox(width: 12,),
                     MealItemTrait(icon: Icons.attach_money, label: affordabilityText),
                    const SizedBox(width: 12,),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
