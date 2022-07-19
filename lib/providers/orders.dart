import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;
  final String userId;
  final String name;
  final String phoneNumber;
  bool delivered;

  OrderItem(
      {@required this.userId,
      @required this.id,
      @required this.amount,
      @required this.dateTime,
        @required this.products,
        @required this.name,
        @required this.phoneNumber,
      this.delivered});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String authToken;
  String userId;
  List<OrderItem> allorders;

  getData(
    String authToken,
    String userId,
    List<OrderItem> orders,
  ) {
    this._orders = orders;
    this.userId = userId;
    this.authToken = authToken;

    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAllOrders() async {
    var url =
        "https://shoper-4b6ea-default-rtdb.firebaseio.com/orders.json?auth=$authToken";
    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      if (data == null) return;
      final List<OrderItem> loadedOrders = [];
      data.forEach((userId, orderId) {
        orderId.forEach((orderId, orderData) {
          loadedOrders.add(
            OrderItem(
                id: orderId,
                userId: orderData['id'],
                amount: orderData['amount'],
                name: orderData['name'],
                phoneNumber: orderData['phoneNumber'],
                dateTime: DateTime.parse(orderData['dateTime']),
                products: (orderData['products'] as List<dynamic>)
                    .map(
                      (e) => CartItem(
                          id: e['id'],
                          title: e['title'],
                          quantity: e['quantity'],
                          price: e['price'],
                          imgUrl: e['imgUrl'],
                          points: e['points']),
                    )
                    .toList(),
                delivered: orderData['delivered']),
          );
        });
      });
      var o =
          loadedOrders.where((element) => element.delivered == false).toList();
      print("${o.length} dsad");
      allorders = o.reversed.toList();
    } catch (e) {
      print(e.toString());
      throw e;
    }
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    var url =
        "https://shoper-4b6ea-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      if (data == null) return;
      final List<OrderItem> loadedOrders = [];
      data.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
              id: orderId,
              delivered: orderData['delivered'],
              userId: orderData['id'],
              amount: orderData['amount'],
              name: orderData['name'],
              phoneNumber: orderData['phoneNumber'],

              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (e) => CartItem(
                        id: e['id'],
                        title: e['title'],
                        quantity: e['quantity'],
                        price: e['price'],
                        imgUrl: e['imgUrl'],
                        points: e['points']),
                  )
                  .toList()),
        );
      });
      _orders = loadedOrders.reversed.toList();
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> delivered(String userId, String orderId) async {
    print("$userId $orderId");
    var url =
        "https://shoper-4b6ea-default-rtdb.firebaseio.com/orders/$userId/$orderId.json?auth=$authToken";
    try {
      await http.patch(url, body: json.encode({'delivered': true}));
    } catch (e) {
      print(e.toString());
      throw e;
    }
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total,
      String userPhoneNumber, String userName, String userAddress) async {
    final url =
        "https://shoper-4b6ea-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";

    try {
      final timestamp = DateTime.now();
      final res = await http.post(url,
          body: json.encode({
            'id': userId,

            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProduct
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                      'imgUrl': e.imgUrl
              ,'points':e.points
                    })
                .toList(),
            'address': userAddress,
            'phoneNumber': userPhoneNumber,
            'name': userName,
            'delivered': false
          }));
      orders.insert(
          0,
          OrderItem(
            name: userName,
            phoneNumber: userPhoneNumber,
            delivered:false,
              id: json.decode(res.body)['name'],
              userId: userId,
              amount: total,
              dateTime: timestamp,
              products: cartProduct,
          ));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
