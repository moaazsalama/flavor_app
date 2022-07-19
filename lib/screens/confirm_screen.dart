import 'package:provider/provider.dart';
import 'package:ver2/providers/cart.dart';
import 'package:ver2/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatefulWidget {
static const String routname='/confirmScreen';



  @override
  _ConfirmrScreen createState() => _ConfirmrScreen();
}



class _ConfirmrScreen extends State<ConfirmScreen> {
  Color mycolor =Color(0xffA9D19B);
  Widget textSection1 =  Text(
    'تم تأكيد طلبك',
    textAlign: TextAlign.center,
    softWrap: true,
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
  );
  Widget textSection2 = Text(

    'سيتم توصيل طلبك في اسرع وقت',
    softWrap: true,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 15,

      fontWeight: FontWeight.w600,
      color: Color(0xffA9D19B),
    ),
  );
  Widget textSection3 =  Text(
    'إجمالي المبلغ المطلوب ',
    textAlign: TextAlign.center,
    softWrap: true,
    style: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );


  @override
  Widget build(BuildContext context) {
    final double total= Provider.of<Cart>(context).totalAmount;
    return Scaffold(
      backgroundColor: mycolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: mycolor,
          elevation: 0.0,
        ),
      ),

      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Mask Group 1.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Column(

                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width:220,
                      child: Image.asset('assets/Mask Group 3.png')
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  textSection1,
                  SizedBox(
                    height: 5,
                  ),
                  textSection2,
                  SizedBox(
                    height: 2,
                  ),
                  textSection3,
                  SizedBox(
                    height: 2,
                  ),
              Text(
                '$total',
                softWrap: true,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.red,
                ),
              ),
                  TextButton(
                     onPressed: ()
                       {
                         Provider.of<Cart>(context,listen: false).clear();
                        Navigator.pushReplacementNamed(
                          context,
                          ProductOverViewScreen.routename,
                        );
                      },
                    child: Text(
                      'العودة للرئيسية',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: mycolor
                      ),
                    ),
                  ),
                ],
              ),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(45),
                ),
                //BorderRadius.circular(20.0,),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

  }
}
