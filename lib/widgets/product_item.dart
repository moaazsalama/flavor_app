import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/auth.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Column(children: [
      Container(
        width: 320,
        height: 200,
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
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductDetailScreen.routname,
                      arguments: product.id),
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/product-placeholder.jpg'),
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                footer: GridTileBar(
                  //      leading: SizedBox(),
                  title: SizedBox.expand(),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  leading: Row(
                    children: [
                      Text(
                        "${product.price}",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.redAccent, fontSize: 30),
                      ),Text(
                        "ج.م",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  trailing: Text(
                    product.title,
                    maxLines: 2,
                    textAlign: TextAlign.right,
                    softWrap: true,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: product.title.length > 20 ? 15 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
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
        child: Builder(
          builder: (ctx) => FlatButton(
            onPressed: () {
              cart.addItem(product);
              
                    print(Provider.of<Auth>(context,listen: false).time);
              Scaffold.of(ctx).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text("!تم اضافة المنتج الي السلة بنجاح"),
                action: SnackBarAction(
                  label: "!تراجع",
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
            child: Text(
              "اضافه الي السلة",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ]);
  }
}

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Column(children: [
      Container(
        width: 320,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                      ProductDetailScreen.routname,
                      arguments: product.id),
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/product-placeholder.jpg'),
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  title: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ))),
      ),
      Container(
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
          onPressed: () {
            cart.addItem(product);
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              duration: Duration(seconds: 2),
              content: Text("تمت الاضافه اي السلة بنجاح !"),
              action: SnackBarAction(
                label: "تراجع !",
                onPressed: () => cart.removeSingleItem(product.id),
              ),
            ));
          },
          child: Text("اضافه الي السلة"),
        ),
      ),
    ]);
  }
}
