import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categoryscreen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'Gluten': false,
    'Lactose': false,
    'Vegan': false,
    'Vegetarian': false
  };
  List<Meal> _avalibalemeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> _filtersData) {
    setState(() {
      _filters = _filtersData;
      _avalibalemeals = DUMMY_MEALS.where((meal) {
        if (_filters['Gluten'] && meal.isGlutenFree == false) return false;
        if (_filters['Lactose'] && meal.isLactoseFree == false) return false;
        if (_filters['Vegan'] && meal.isVegan == false) return false;
        if (_filters['Vegetarian'] && meal.isVegetarian == false) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealid) {
    final existingIndex = _favoriteMeals.indexWhere((element) =>
    element.id == mealid);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else {
      setState(() {
        _favoriteMeals.add(
            DUMMY_MEALS.firstWhere((element) => element.id == mealid));
      });
    }
  }

  bool _isMealFavorite(String mealid)
  {
    return _favoriteMeals.any((element) => element.id==mealid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 220, 1),
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            // ignore: deprecated_member_use
              body1: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
              // ignore: deprecated_member_use
              body2: TextStyle(color: Color.fromRGBO(255, 254, 220, 1)),
              // ignore: deprecated_member_use
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      routes: {
        '/': (context) => TabScreen(_favoriteMeals),
        CategoryScreen.routname: (context) => CategoryScreen(),
        CategoryMealScreen.routname: (context) =>
            CategoryMealScreen(_avalibalemeals,),
        MealDetailScreen.routname: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routename: (context) => FilterScreen(_setFilters)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: Container(child: CategoryScreen()),
    );
  }
}
