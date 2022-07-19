import 'package:flutter/material.dart';
import 'package:ver2/providers/product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;
  final int points;
  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.imgUrl,
      @required this.points});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void addItem(Product product, {bool points = false}) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (productItem) => CartItem(
              id: productItem.id,
              price: productItem.price,
              quantity: productItem.quantity + 1,
              title: productItem.title,
              imgUrl: productItem.imgUrl,
              points: productItem.points));

      notifyListeners();
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: product.title,
              quantity: 1,
              price: product.price,
              imgUrl: product.imageUrl,
              points: points ? 0 : product.points));
      notifyListeners();
    }
  }

  void removeItem(String prodid) {
    _items.remove(prodid);
    notifyListeners();
  }

  incrementItem(String prodid) {
    if (_items[prodid].quantity >= 1) {
      _items.update(
          prodid,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price,
              imgUrl: value.imgUrl,
              points: value.points));
    }
    print(_items[prodid].quantity);
    notifyListeners();
  }

  void removeSingleItem(String prodid) {
    if (!_items.containsKey(prodid)) return;
    if (_items[prodid].quantity > 1) {
      _items.update(
          prodid,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price,
              imgUrl: value.imgUrl,
              points: value.points));
    } else {
      _items.remove(prodid);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
