import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/models/googlesheets.dart';
import 'package:ver2/providers/my_flutter_app_icons.dart';
import 'package:ver2/providers/user.dart';
import 'package:ver2/screens/%D9%8Fedit_screen.dart';
import 'package:ver2/screens/confirm_screen.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static String routname = "/Cart-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserAuth>(context);

    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("اسحب يسارا لحذف المنتج",style: TextStyle(color: Colors.redAccent,fontSize: 20),)),
          Expanded(
            child: cart.items.length > 0
                ? ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (BuildContext context, int index) => CartItem(
                      id: cart.items.values.toList()[index].id,
                      title: cart.items.values.toList()[index].title,
                      price: cart.items.values.toList()[index].price,
                      productId: cart.items.keys.toList()[index],
                      quantity: cart.items.values.toList()[index].quantity,
                      imgUrl: cart.items.values.toList()[index].imgUrl,
                    ),
                  )
                : Center(
                    child: Text(
                    "لم تتم اضافة اي منتجات لسلة المشتريات بعد  ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    textAlign: TextAlign.center,
                  )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FlatButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, EditProfile.routname);
                  },
                  icon: Icon(
                    MyFlutterApp.icon_material_edit,
                    color: Colors.redAccent,
                  ),
                  label: Text(
                    "تعديل ",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                Text(
                  "تقاصيل التوصيل",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Card(
            elevation: 3,
            margin: EdgeInsets.all(15),
            child: Container(
              height: 120,
              width: double.infinity,
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
          Card(
            elevation: 0,
            margin: EdgeInsets.all(15),
            child: Container(
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "اجمالي سعر المطلوب",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ج.م',
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${cart.totalAmount.floorToDouble()}',
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrderButton(cart: cart),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({
    @required this.cart,
  });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userAuth = Provider.of<UserAuth>(context);
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: FlatButton(
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                "اتمام عملية الشراء ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        onPressed: (widget.cart.itemCount < 0 || _isLoading)
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  var items = widget.cart.items.values.toList();
                  await Provider.of<Orders>(context, listen: false).addOrder(
                      items,
                      widget.cart.totalAmount,
                      userAuth.phoneNumber,
                      userAuth.name,
                      userAuth.address,
                  );
                  String item = "";
                  items.forEach((e) {
                    item += "${e.title} (${e.quantity}),";
                  });
                  print(userAuth.phoneNumber);
                  var user = {
                    UserFields.productsName: item,
                    UserFields.userName: userAuth.name,
                    UserFields.userPhoneNumber: "+2${userAuth.phoneNumber}",
                    UserFields.userAdress: userAuth.address,
                    UserFields.date: DateTime.now().toString(),
                    UserFields.totalPrice: widget.cart.totalAmount
                  };
                  UserSheetApi.insert(user);
                  Navigator.pushReplacementNamed(
                      context, ConfirmScreen.routname);

                  setState(() {
                    _isLoading = false;
                  });
                },
        textColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
