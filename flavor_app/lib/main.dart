
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/screens/%D9%8Fedit_screen.dart';
import 'package:ver2/screens/confirm_screen.dart';
import 'package:ver2/screens/product_screen.dart';
import './screens/auth_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './providers/auth.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';

import './screens/splash_screen.dart';
import 'models/googlesheets.dart';
import 'providers/admins.dart';
import 'providers/user.dart';
import 'screens/admins_Screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),

        ChangeNotifierProxyProvider<Auth, UserAuth>(
          create: (context) => UserAuth(),
          update: (ctx, authvalue, previousUser) =>
              previousUser..getData(authvalue.token, authvalue.userID),
        ),
        ChangeNotifierProxyProvider<Auth, Admins>(
          create: (context) => Admins(),
          update: (ctx, authvalue, previousUser) =>
          previousUser..fetechAdmins(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(),
          update: (ctx, authvalue, previousOrders) => previousOrders
            ..getData(authvalue.token, authvalue.userID,
                previousOrders == null ? [] : previousOrders.orders),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(),
          update: (ctx, authvalue, previousProducts) => previousProducts
            ..getData(authvalue.token, authvalue.userID,
                previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, value, child) {
          var admins = Provider.of<Admins>(context,listen: true);
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color.fromARGB(255, 169, 209, 156),
              accentColor: Colors.deepOrange,
              fontFamily: 'Arabic',
              bottomNavigationBarTheme: BottomNavigationBarThemeData()),
          home: value.isAuth
               ?admins.isAdmin(value.email)?AdminsScreen():ProductOverViewScreen()
              : FutureBuilder(
            
                  future: Future.delayed(Duration(seconds: 2,),()=>value.tryAutoLogin()),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            ProductOverViewScreen.routename: (_) => ProductOverViewScreen(),
            ProductDetailScreen.routname: (_) => ProductDetailScreen(),
            CartScreen.routname: (_) => CartScreen(),
            OrderScreen.routname: (_) => OrderScreen(),
            AdminsScreen.routname:(_)=>AdminsScreen(),
            ProductScreen.route: (_) => ProductScreen(),
            ConfirmScreen.routname: (_) => ConfirmScreen(),
            EditProfile.routname: (_) => EditProfile(),
            AuthScreen.routename:(_)=>AuthScreen()
          },
        );
        },
      ),
    );
  }
}
