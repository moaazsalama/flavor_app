import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${order.amount}\$',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(DateFormat('dd/MM/yyyy').format(order.dateTime)),
          ],
        ),
        subtitle: Text("عدد المنتجات ${order.products.length}"),
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
                    '${product.quantity} x \$${product.price} ',
                    style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      product.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
