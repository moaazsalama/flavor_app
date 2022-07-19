import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/product.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final int sign;

  const ProductsGrid({Key key, this.sign}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    var products;
    if (sign == 1)
      products =
          productData.items.where((element) => element.isFood == 1).toList();
    else if (sign == 2)
      products =
          productData.items.where((element) => element.isDrinks == 1).toList();
    else if (sign == 3)
      products =
          productData.items.where((element) => element.isOffer == 1).toList();
    else if (sign == 4)
      products =
          productData.items.where((element) => element.isFasting == 1).toList();
    else
      products = [];

    return products.isEmpty
        ? Center(
            child: Text("There is no product"),
          )
        : ListView.builder(
            padding: EdgeInsets.all(18),
            itemCount: products.length,
            itemBuilder: (context, index) => ChangeNotifierProvider<Product>.value(
              value: products[index],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductItem(),
              ),
            ),
          );
  }
}
