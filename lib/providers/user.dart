import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserAuth with ChangeNotifier {
  String id;
  String email;
  String address;
  String name;
  String phoneNumber;
  int myPoints;
  String authToken;

  UserAuth(
      {@required this.myPoints,
      @required this.id,
      @required this.email,
      @required this.phoneNumber,
      @required this.address,
      @required this.name});
  getData(String authToken, String userId) {
    this.authToken = authToken;
    id = userId;
    fetchUser(userId, authToken);
    notifyListeners();
  }

  Future<void> addUser(UserAuth userAuth, String token) async {
    final url =
        "https://shoper-4b6ea-default-rtdb.firebaseio.com/users/${userAuth.id}.json?auth=$token";

    try {
      await http.patch(url,
          body: json.encode({
            'id': userAuth.id,
            'name': userAuth.name,
            'email': userAuth.email,
            'address': userAuth.address,
            'phoneNumber': userAuth.phoneNumber,
            'myPoints': userAuth.myPoints.toString(),
          }));

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(UserAuth userAuth, String token) async {
    try {
      final url =
          "https://shoper-4b6ea-default-rtdb.firebaseio.com/users/$id.json?auth=$authToken";

      await http.patch(url,
          body: json.encode({
            'name': userAuth.name,
            'address': userAuth.address,
            'phoneNumber': userAuth.phoneNumber,
            'myPoints': userAuth.myPoints.toString(),
          }));
      this.name = userAuth.name;
      this.address = userAuth.address;
      this.phoneNumber = userAuth.phoneNumber;
      notifyListeners();
    } catch (error) {}


  }

  Future<void> addPointToUser(String userId, String token,int points) async {
    try {
      final url =
          "https://shoper-4b6ea-default-rtdb.firebaseio.com/users/$userId.json?auth=$token";
      var response = await http.get(url);
      Map<String, dynamic> data = json.decode(response.body)as Map<String, dynamic>;
      points+=int.parse(data['myPoints']);
      await http.patch(url,
          body: json.encode({

            'myPoints': points.toString(),
          }));
      notifyListeners();
    } catch (error) {}


  }

  Future<void> fetchUser(String userId, String authToken) async {
    if(authToken==null)
      return;
    var url =
        "https://shoper-4b6ea-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken";
    try {
      final res = await http.get(url);

      final Map<String, dynamic> data =
          json.decode(res.body) as Map<String, dynamic>;



      if (data == null) {
        return;
      }
      print(data['myPoints']);
      id = data['id'];
      name = data['name'];
      email = data['email'];
      phoneNumber = data['phoneNumber'];
      address = data['address'];
      myPoints = int.parse(data['myPoints']);
      notifyListeners();
    } catch (e) {
      throw e;
    }

  }
  clear(){
    this.authToken=null;
    this.name=null;
    this.email=null;
    this.id=null;
    this.myPoints=null;
    this.phoneNumber=null;
    this.address=null;
    notifyListeners();
  }
}
