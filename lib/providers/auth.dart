import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiry;
  Timer _authTimer;
  String _userId;
  String email;
  String password;
  bool get isAuth {
    return token != null;
  }

  bool get isExpiry {
    if (_expiry != null &&
        email != null &&
        password != null &&
        _expiry.isAfter(DateTime.now())) return true;
  }

  int get time => _expiry.difference(DateTime.now()).inMinutes;
  String get token {
    if (_expiry != null && _expiry.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  String get userID {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBwiwGJ8vIvA3uG1r81FRSYlE2UVFl-QY0';
    try {
      final res = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(res.body);
      if (responseData['error'] != null) {
        print(responseData['error']['message']);
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      print(_token);
      _userId = responseData['localId'];
      this.email = responseData['email'];
      this.password = password;
      _expiry = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      notifyListeners();
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiry.toIso8601String(),
        'email': this.email,
        'password': this.password
      });

      pref.setString('userData', userData);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> resetPassowrd(String email) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyBwiwGJ8vIvA3uG1r81FRSYlE2UVFl-QY0';
    try {
      final res = await http.post(url,
          body: json.encode({"requestType": "PASSWORD_RESET", "email": email}));
      final responseData = json.decode(res.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    final Map<String, Object> userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      await refreshToken(userData['email'], userData['password']);
      notifyListeners();

      return true;
    }
    _token = userData['token'];
    _userId = userData['userId'];
    email = userData['email'];
    _expiry = expiryDate;
    password = userData['password'];
    notifyListeners();

    return true;
  }

  refreshToken(email, password) async {
    return await login(email, password);
  }

  Future<void> logout() async {
    _expiry = null;
    _token = null;
    _userId = null;
    email = null;
    password = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final shared = await SharedPreferences.getInstance();

    await shared.clear();
    notifyListeners();
  }
}
