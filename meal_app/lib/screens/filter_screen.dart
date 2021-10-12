import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static String routename = "/filter";
  final Function savefilters;

   FilterScreen(this.savefilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false,
      _isLactoseFree = false,
      _isVegan = false,
      _isVegetarian = false;

  // ignore: non_constant_identifier_names
  Widget BulidSwitch(String title, String subtitle, bool flag, Function f) {
    return SwitchListTile(
      value: flag,
      title: Text(title),
      subtitle: Text(subtitle),
      onChanged: f,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed:(){
             final  savedfitlers = {
              'Gluten': _isGlutenFree,
              'Lactose': _isLactoseFree,
              'Vegan': _isVegan,
              'Vegetarian': _isVegetarian
            };


            widget.savefilters(savedfitlers);})
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            // ignore: deprecated_member_use
            child: Text(
              "Adjust your meal selection",
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              BulidSwitch("GlutenFree", "Only Include GlutenFree meals.",
                  _isGlutenFree, (value) {setState(() {
                    _isGlutenFree=value;
                  });}),
              BulidSwitch("Lactose-free", "Only Include Lactose meals.",
                  _isLactoseFree,(value) {setState(() {
                    _isLactoseFree=value;
                  });}),
              BulidSwitch("Vegan-free", "Only Include Vegan meals.", _isVegan,(value) {setState(() {
                _isVegan=value;
              });}),
              BulidSwitch("Vegetarian-free", "Only Include Vegetarian meals.",
                  _isVegetarian,(value) {setState(() {
                    _isVegetarian=value;
                  });}),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
