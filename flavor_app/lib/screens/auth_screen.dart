import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/user.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

Size devicesize;

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);
  static const String routename = "/auth";

  @override
  Widget build(BuildContext context) {
    devicesize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 169, 209, 156),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Mask Group 1.png"),
                  fit: BoxFit.cover),
            ),
          ),
          AuthCard(),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

enum AuthMode { Login, SignUp, Reset }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authMap = {
    'email': '',
    'password': '',
    'phoneNumber': '',
    'name': '',
    'address': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slidAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slidAnimation = Tween<Offset>(begin: Offset(0, -15), end: Offset(0, 0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _reset(String email) async {
    try {
      await Provider.of<Auth>(context, listen: false).resetPassowrd(email);
    } on HttpException catch (error) {
      var errorMessage = "خطا في الاتصال";
      if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "البريد الالكتروني غير صحيح ";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      _showErrorDialog("مشكله في الاتصال");
    }
  }

  Future<void> _submit() async {
    var auth = Provider.of<Auth>(context, listen: false);
    if (!_formKey.currentState.validate()) return;

    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login)
        await Provider.of<Auth>(context, listen: false)
            .login(_authMap['email'], _authMap['password']);
      else if (_authMode == AuthMode.SignUp) {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authMap['email'], _authMap['password']);
        await  Provider.of<UserAuth>(context,listen: false).addUser(UserAuth(myPoints: 0, id: auth.userID, email: _authMap['email'], phoneNumber: _authMap['phoneNumber'], address: _authMap['address'], name: _authMap['name']), auth.token);

      } else {
        await _reset(_authMap['email']);

      }

    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "البريد مستخدم بلفعل";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "البريد غير صحيح ";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "البريد غير صالح ";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This Password is Weak";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "كلمة السر غير صحيحه";
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      const errorMessage =
          "Could not authenticate you. Please Try Again Later.";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _authMode = AuthMode.Login;
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("خطأ", style: TextStyle(fontSize: 20)),
              content: Text(message, style: TextStyle(fontSize: 20)),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      "حسنا",
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ));
  }

  void _switchMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,

      constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.SignUp ? 550 : 470),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_authMode != AuthMode.Reset)
                Text(
                  "مرحبا بعودتك",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
              if (_authMode != AuthMode.Reset)
                Text(
                  "قم بتسجيل الدخول الان",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  labelText: 'البريد الالكتروني ',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (!value.contains('@') || value.isEmpty)
                    return "البريد الالكتروني غير صالح";
                  return null;
                },
                onSaved: (newValue) {
                  _authMap['email'] = newValue;
                },
              ),
              if (_authMode != AuthMode.Reset)
                SizedBox(
                  height: 10,
                ),
              if (_authMode != AuthMode.Reset)
                TextFormField(


                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    labelText: 'كلمة السر',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  validator: (value) {
                    if (value.length <= 7 || value.isEmpty)
                      return "كلمة المرور غير صالحة";
                    return null;
                  },
                  onSaved: (newValue) {
                    _authMap['password'] = newValue;
                  },
                ),
              if (_authMode != AuthMode.Reset)
                SizedBox(
                height: 10,
              ),
              if (_authMode != AuthMode.Reset)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.SignUp ? 70 : 0,
                      maxHeight: _authMode == AuthMode.SignUp ? 140 : 0),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slidAnimation,
                      child: TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          labelText: 'تأكيد كلمة السر',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autocorrect: false,
                        validator: _authMode == AuthMode.SignUp
                            ? (value) {
                                if (value != _passwordController.text ||
                                    value.isEmpty)
                                  return "يرجي التحقق من كلمة السر";
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
              if (_authMode != AuthMode.Reset)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.SignUp ? 70 : 0,
                      maxHeight: _authMode == AuthMode.SignUp ? 140 : 0),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slidAnimation,
                      child: TextFormField(
                        onSaved: (newValue) => _authMap['name']=newValue,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          labelText: 'الاسم',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: _authMode == AuthMode.SignUp
                            ? (value) {
                                if (value.isEmpty)
                                  return "يرجي التحقق من الاسم ";
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
              if (_authMode != AuthMode.Reset)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.SignUp ? 70 : 0,
                      maxHeight: _authMode == AuthMode.SignUp ? 140 : 0),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slidAnimation,
                      child: TextFormField(
                        onSaved: (newValue) => _authMap['address']=newValue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          labelText: 'العنوان',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: _authMode == AuthMode.SignUp
                            ? (value) {
                                if (value.isEmpty)
                                  return "يرجي التحقق من العنوان";
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
              if (_authMode != AuthMode.Reset)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.SignUp ? 70 : 0,
                      maxHeight: _authMode == AuthMode.SignUp ? 140 : 0),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slidAnimation,
                      child: TextFormField(
                        onSaved: (newValue) => _authMap['phoneNumber']=newValue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          labelText: 'رقم الهاتف',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        autocorrect: false,
                        validator: _authMode == AuthMode.SignUp
                            ? (value) {
                                if (value.length!=11)
                                  return "يرجي التحقق من رقم الهاتف";
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
              if (_authMode == AuthMode.Login)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _authMode = AuthMode.Reset;
                        });
                      },
                      child: Text(
                        "نسيت كلمة السر",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              if (_authMode != AuthMode.Reset)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لست عميل سابق؟",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    FlatButton(
                      onPressed: _switchMode,
                      child: Text(
                        '${_authMode == AuthMode.Login ? "انشئ حساب " : "لدي حساب بلفعل"} ',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ].reversed.toList(),
                ),
              if (_isLoading) CircularProgressIndicator(),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                alignment: Alignment.center,
                child: RaisedButton(
                  child: Center(
                    child: Text(
                      _authMode == AuthMode.Login
                          ? "   تسجيل دخول  "
                          : _authMode == AuthMode.SignUp
                              ? "     انشاء حساب     "
                              : "  أستعادة كلمة السر     ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  onPressed: _submit,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
              if (_authMode == AuthMode.Reset)
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _authMode = AuthMode.Login;
                    });
                  },
                  child: Text(
                    "     تسجيل الدخول    ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
