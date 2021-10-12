
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imgUrl;

  const CartItem(
      {this.id,
      this.productId,
      this.quantity,
      this.price,
      this.title,
      this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("هل انت متأكد ؟",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            content: Text("تريد حذف هذا المنتج من السلة ؟",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("لا")),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("نعم")),
            ],
          ),
        );
      },
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItem(productId),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,


                children: [

                  Column(
crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Container(
                        width: 150,
                        height: 50,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,

                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'ج.م',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "$price",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                  Expanded(child: Center(child: Text("${quantity}x",style: TextStyle(color: Colors.red,fontSize: 20),))),
                  Expanded(child: IconButton(
                    onPressed: (){
                      Provider.of<Cart>(context, listen: false).incrementItem(productId);
                    },
                    icon:Icon(Icons.add)
                  )),
                 Expanded(child: IconButton(
                    onPressed: (){
                      Provider.of<Cart>(context, listen: false).removeSingleItem(productId);
                    },
                    icon:Icon(Icons.remove)
                  )),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(

                        imgUrl,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
