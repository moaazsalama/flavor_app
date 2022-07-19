import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ver2/providers/user.dart';
import 'package:ver2/screens/admin_order_screen.dart';
import 'package:ver2/screens/order_screen.dart';

class AdminsScreen extends StatelessWidget {
  static const String routname = "/admin";

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAuth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Mr ${user.name}"),
      ),
      body: AdminOrderScreen(),
    );
  }
}
