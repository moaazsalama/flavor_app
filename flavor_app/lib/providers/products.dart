import 'package:flutter/material.dart';
import 'package:ver2/models/googlesheets.dart';
import '../providers/product.dart';
class Products with ChangeNotifier {
  List<Product> _items = [
  ];
  String authToken;
  String userId;

  getData(String authToken, String userId, List<Product> products) {
    this._items = products;
    this.userId = userId;
    this.authToken = authToken;
    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  Product findItemById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final List<Map<String, String>> pros = await UserSheetApi.fetchData();

      final List<Product> loadedProducts = [];
      pros.forEach((prodData) {
        loadedProducts.add(
          Product(
            id: prodData['id'],
            description: prodData['description'],
            price: double.parse(prodData['price']),
            title: prodData['title'],
            imageUrl: prodData['imageUrl'],
            points: int.parse(prodData['points']),
            isFood: int.parse(prodData['isFood']),
            isDrinks: int.parse(prodData['isDrinks']),
            isOffer: int.parse(prodData['isOffer']),
            isFasting: int.parse(prodData['isFasting']),
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {}
  }
}
