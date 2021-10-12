import 'package:flutter/material.dart';
import "package:meal_app/dummy_data.dart";
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/mealItem.dart';

class CategoryMealScreen extends StatefulWidget {

  static const routname = '/categorymealsscreen';
  final List <Meal> availableMeals;
  CategoryMealScreen(this.availableMeals);
  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categorytitle;

  List<Meal> categoryMeals;
  @override
  void didChangeDependencies() {
    final arg =ModalRoute.of(context).settings.arguments as Map<String,String>;
    final categoryid=arg['id'];
    categorytitle=arg['title'];
    categoryMeals=widget.availableMeals.where((meals)
    {
      return meals.categories.contains(categoryid);
    }
    ).toList();
    super.didChangeDependencies();
  }
  @override
  // ignore: must_call_super
  void initState() {
    }
  @override
  // ignore: override_on_non_overriding_member

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categorytitle),

      ),
      body:ListView.builder(
          itemBuilder: (ctx,index)
              {
                return MealItem(
                  id: categoryMeals[index].id,
                  imageUrl: categoryMeals[index].imageUrl,
                  title: categoryMeals[index].title,
                  affordability: categoryMeals[index].affordability,
                  complexity: categoryMeals[index].complexity,
                  duration: categoryMeals[index].duration,

                );
              },
        itemCount: categoryMeals.length,
      ),

    );
  }
}
