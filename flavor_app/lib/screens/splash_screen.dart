import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: BoxDecoration(
         color: Colors.black54

            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png"),
                CircularProgressIndicator()
              ],
            ),
          )        ],
      )
    );
  }
}
