import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/mealItem.dart';
class FavoriteScreen extends StatelessWidget {
  List <Meal> _Fav;
 FavoriteScreen(this._Fav);
  @override
  Widget build(BuildContext context) {
    if(_Fav.isEmpty)
      return Center(
        child: Text("You Have no Favorite Yet -Start Adding Some"),
      );
    else
    return Scaffold(
    body: ListView.builder(
      itemBuilder: (ctx,index)
      {
        return MealItem(
          id: _Fav[index].id,
          imageUrl: _Fav[index].imageUrl,
          title: _Fav[index].title,
          affordability: _Fav[index].affordability,
          complexity: _Fav[index].complexity,
          duration: _Fav[index].duration,
        );
      },
      itemCount: _Fav.length,
    ),

    );
  }
}
