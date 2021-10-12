import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem( this.id, this.title, this.color);
  @override
  Widget build(BuildContext context) {
    void selectCategory(BuildContext ctx){
      Navigator.of(context).pushNamed(CategoryMealScreen.routname,
      arguments: {
        'id':id,
        'title':title,
      });
    }
    return InkWell(

     splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
          selectCategory(context);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        // ignore: deprecated_member_use
        child: Text(title,style: Theme.of(context).textTheme.title),
        decoration:BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(.5),
                  color
                ]
            )
        ),
      ),
    );
  }
}
