import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categoryscreen.dart';
import 'package:meal_app/screens/favorites_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  List <Meal> _favorite;
  TabScreen(this._favorite);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // ignore: non_constant_identifier_names
   List<Map<String,Object>> Pages;
  int _selectedpage = 0;
  @override
  void initState() {
    Pages=[
      {
        'page':CategoryScreen(),
        'title':'Categories'
      },
      {
        'page':FavoriteScreen(widget._favorite),
        'title':'Your Favorites'
      }
    ];
    super.initState();
  }
  // ignore: non_constant_identifier_names
  void _SelectPage(int value) {
    setState(() {
      _selectedpage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Pages[_selectedpage]['title']),
      ),
      body: Pages[_selectedpage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedpage,
        onTap: _SelectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              // ignore: deprecated_member_use
              title: Text("Categories")),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              // ignore: deprecated_member_use
              title: Text("Favorites")),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
