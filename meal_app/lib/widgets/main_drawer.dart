import 'package:flutter/material.dart';
import 'package:meal_app/screens/filter_screen.dart';
class MainDrawer extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Widget BuildListTile(String s,IconData icon,Function f)
  {
    return ListTile(
      leading: Icon(icon,size: 26,),
      title: Text(s,
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            color: Colors.black

        ),
      ),
      onTap: f,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text("Cooking Up!",style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),),
          ),
          SizedBox(height: 20,),
          BuildListTile("Meal", Icons.restaurant,(){Navigator.of(context).pushReplacementNamed('/'); }),
          BuildListTile("Filter", Icons.settings,()=>Navigator.of(context).pushReplacementNamed(FilterScreen.routename))
        ],
      ),
    );
  }
}
