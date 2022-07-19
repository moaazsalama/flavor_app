import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/cart.dart';
import 'package:ver2/providers/product.dart';
import 'package:ver2/providers/products.dart';
import 'package:ver2/providers/user.dart';

class Points extends StatefulWidget {
  @override
  _Points createState() => _Points();
}

class _Points extends State<Points> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context).items;
    final userAuth = Provider.of<UserAuth>(context);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Container(
              width: double.infinity,
              height: 230,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColor, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          width: 200,
                          height: 175,
                          child: Image.asset('assets/Mask Group 8.png')),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Text(
                      'إجمالي عدد النقاط',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 115,
                    child: Text("${userAuth.myPoints} نقطة",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "استبدال النقاط",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  builder: (context) => ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Container(
                                          height: 150,
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(30),
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "سيتم استبدال نقاطك ب ${product[index].title}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Center(
                                                            child: Text(
                                                          "الغاء ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.white)),
                                                    child: FlatButton(
                                                        onPressed: () async {
                                                          if (userAuth
                                                                  .myPoints >=
                                                              product[index]
                                                                  .points) {
                                                            var newProduct = Product(
                                                                points: product[
                                                                        index]
                                                                    .points,
                                                                id: product[
                                                                        index]
                                                                    .id,
                                                                title: product[
                                                                        index]
                                                                    .title,
                                                                description: product[
                                                                        index]
                                                                    .description,
                                                                price: 0,
                                                                imageUrl: product[
                                                                        index]
                                                                    .imageUrl);
                                                            cart.addItem(

                                                                newProduct,points: true);
                                                            UserAuth newUser =
                                                                userAuth;
                                                            newUser.myPoints -=
                                                                product[index]
                                                                    .points;
                                                            await userAuth
                                                                .updateUser(
                                                                    newUser,
                                                                    userAuth
                                                                        .authToken);
                                                                         Fluttertoast.showToast(
                                                                msg:
                                                                    "تمت الاضافه بنجاح",toastLength: Toast.LENGTH_LONG);
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "لا يوجد نقاط كافيه",toastLength: Toast.LENGTH_LONG);
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            "موافق",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: Hero(
                              tag: product[index].id,
                              child: FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/product-placeholder.jpg'),
                                image: NetworkImage(product[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          footer: GridTileBar(
                            //      leading: SizedBox(),
                            title: SizedBox.expand(),
                            backgroundColor: Colors.black.withOpacity(0.7),
                            leading: Text(
                              "${product[index].points}\$",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 30),
                            ),
                            trailing: Text(
                              product[index].title,
                              maxLines: 2,
                      textAlign: TextAlign.right,
                     
                      textDirection: TextDirection.rtl,
                              
                              style:
                                    TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: product.length,
            ),
          )
        ],
      ),
    ));
  }
}

/*Container(
alignment: Alignment.topRight,
child: Text(
'استبدال النقاط',
style: TextStyle(
fontSize: 35,
fontWeight: FontWeight.bold,
),

),
),*/