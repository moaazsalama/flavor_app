import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/screens/menu_screen.dart';
import 'package:ver2/screens/mypoints_screen.dart';
import 'package:ver2/screens/order_screen.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';



import '../providers/my_flutter_app_icons.dart';

class ProductOverViewScreen extends StatefulWidget {
  static String routename = "Product-overview";

  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

enum FilterOption { Favorites, All }
int index=1;
class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  // ignore: unused_field
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages=[Points(),
      MenuScreen(),
      OrderScreen(),CartScreen()];
    var appBars=[
      "نقاطي",
      "المنيو",
      "صفحتي",
      "طلباتي"
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(appBars[index],style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
  backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          :pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        fixedColor: Colors.white,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        selectedFontSize: 25,
        iconSize: 20,
        unselectedFontSize: 15,
        currentIndex: index,
        onTap: (value) async{
         
          setState(() {
            index=value;
          });
        },

        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(MyFlutterApp.dt__e),
            label: "نقاطي ",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(MyFlutterApp.todnf,color: Colors.black,),
            label: "المنيو ",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(MyFlutterApp.s__e,color: Colors.black,),
            label: "صفحتي ",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(MyFlutterApp.t___e,color: Colors.black,),
            label: "طلباتي ",


          ),
        ],
      ),
    );
  }
}

