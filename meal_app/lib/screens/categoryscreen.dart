import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/widgets/categoryitem.dart';


class CategoryScreen extends StatelessWidget {

  static const routname = '/categoryscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: GridView(
        padding: EdgeInsets.all(15),
        children: DUMMY_CATEGORIES.map((catchdata) =>
            CategoryItem(catchdata.id, catchdata.title, catchdata.color)
        ).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
