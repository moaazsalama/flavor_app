import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/orders.dart';
import 'package:ver2/providers/user.dart';
import '../providers/orders.dart' as ord;

class AdminOrderItem extends StatelessWidget {
  final ord.OrderItem order;

   AdminOrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(

              children: [
                Text(
                  'جنيه',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '${order.amount}',
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Text("${DateFormat('yyyy-MM-dd hh:mm').format(order.dateTime)}التاريخ"),
        ],
      ),
      subtitle: Text("عدد المنتجات ${order.products.length}"),
      leading: IconButton(onPressed: ()async{
        print(order.userId);
      await Provider.of<Orders>(context,listen: false).delivered(order.userId, order.id);
        int points=0;
      order.products.forEach((element) =>points+=element.points);
      Provider.of<UserAuth>(context,listen: false).addPointToUser(order.userId,Provider.of<UserAuth>(context,listen: false).authToken,points );
      }, icon: Icon(Icons.delivery_dining_outlined)),
      children: order.products.map((product) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(

                    product.imgUrl,
                    fit: BoxFit.cover,

                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  product.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${product.quantity} x \$${product.price} ',
                  style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
