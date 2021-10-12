import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/products.dart';
import 'package:ver2/widgets/products_grid.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(
              child: Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "الماكولات",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Tab(
              child: Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "المشروبات",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Tab(
              child: Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "العروض",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Tab(
              child: Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "الصيامي",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(children: <Widget>[
          Container(
            child: Center(
              child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<Products>(context, listen: false)
                        .fetchAndSetProducts();
                  },
                  child: ProductsGrid(sign: 1,)),
            ),
          ),
          Container(
            child: Center(
              child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<Products>(context, listen: false)
                        .fetchAndSetProducts();
                  },
                  child: ProductsGrid(sign: 2,)),
            ),
          ),
          Container(
            child: Center(
              child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<Products>(context, listen: false)
                        .fetchAndSetProducts();
                  },
                  child: ProductsGrid(sign: 3,)),
            ),
          ),
          Container(
            child: Center(
              child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<Products>(context, listen: false)
                        .fetchAndSetProducts();
                  },
                  child: ProductsGrid(sign: 4,)),
            ),
          ),
        ]),
      ),
    );
  }
}
