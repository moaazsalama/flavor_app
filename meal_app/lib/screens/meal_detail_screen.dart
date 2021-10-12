import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static final routname = "/mealdetailscreen";
  final Function toggleFavorite, isMealFavorite;
  MealDetailScreen(this.toggleFavorite, this.isMealFavorite);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool toggle = false;

  @override
  // ignore: non_constant_identifier_names, override_on_non_overriding_member
  Widget BuildContainer(Widget c) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: c,
    );
  }

  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Widget Title(String s) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          // ignore: deprecated_member_use
          child: Text(s, style: Theme.of(context).textTheme.title));
    }

    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Title("Ingredients"),
            BuildContainer(ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                );
              },
              itemCount: selectedMeal.ingredients.length,
            )),
            Title("Steps"),
            BuildContainer(ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(widget.isMealFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: (){widget.toggleFavorite(mealId);},
      ),
    );
  }
}
