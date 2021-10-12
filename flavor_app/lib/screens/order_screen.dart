import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/auth.dart';
import 'package:ver2/providers/my_flutter_app_icons.dart';
import 'package:ver2/screens/%D9%8Fedit_screen.dart';
import '../providers/user.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import 'auth_screen.dart';

class OrderScreen extends StatefulWidget {
  static String routname = "/order-screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth>(context,listen: false);
    return Scaffold(
        body: FutureBuilder(
      future: user.fetchUser(user.id, user.authToken),
      builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator()):Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton.icon(
                      onPressed: () {
                        Provider.of<Auth>(context,listen: false).logout();
                        print(Provider.of<Auth>(context,listen: false).isAuth);
                        Provider.of<UserAuth>(context,listen: false).clear();


                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Colors.redAccent,
                      ),
                      label: Text(
                        "تسجيل خروج",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, EditProfile.routname);
                      },
                      icon: Icon(
                        MyFlutterApp.icon_material_edit,
                        color: Colors.redAccent,
                      ),
                      label: Text(
                        "تعديل الحساب",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 3,
                margin: EdgeInsets.all(15),
                child: Container(
                  height: 120,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${user.name}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ":الاسم",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${user.address}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ":العنوان",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${user.phoneNumber}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ":رقم الهاتف",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "طلباتي السابقة ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<Orders>(context, listen: false)
                      .fetchAndSetOrders(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    else if (snapshot.hasError) {

                      return Center(
                        child: Text("حدث خطأ"),
                      );
                    } else
                      return Consumer<Orders>(

                        builder: (ctx, ordervalue, child) {

                          return ordervalue
                              .orders ==
                              null
                              ? Text("لايوجد طلبات حتي الان")
                              : ListView.builder(
                            itemCount: ordervalue.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OrderItem(ordervalue.orders[index]);
                            },
                          );
                        },
                      );
                  },
                ),
              )
            ],
          )),
        ));
  }
}
