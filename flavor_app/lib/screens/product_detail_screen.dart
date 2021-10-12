import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/screens/cart_screen.dart';
import 'package:ver2/screens/product_overview_screen.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatefulWidget {
  static String routname = "/product-detail";

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
    Provider.of<Products>(context, listen: false).findItemById(productId);

    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      loadedProduct.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          'ج.م',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          '${loadedProduct.price}',
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                          ),
                        ),

                        Expanded(
                          /*1*/
                          child: Column(
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(left: 65),
                                child:  Text(
                                  loadedProduct.title,
                                  maxLines: 2,

                      textAlign: TextAlign.right,
                     
                      textDirection: TextDirection.rtl,
                   
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      loadedProduct.description,
                      softWrap: true,
                      
                      textAlign: TextAlign.right,
                     
                      textDirection: TextDirection.rtl,
                   
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width-20,
              height: 70,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed:(){

                    Provider.of<Cart>(context,listen: false).addItem(loadedProduct);
                    showModalBottomSheet(context: context,isDismissible: true, builder: (context) => Container(
                      height: 200,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FlatButton(onPressed: () {
                              Navigator.of(context).pushReplacementNamed(ProductOverViewScreen.routename);
                            }, child: Center(child: Text("اكمال التسويق ",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight:FontWeight.bold),))),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 2,color: Theme.of(context).primaryColor)
                            ),
                            child: FlatButton(onPressed: () {

                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(CartScreen.routname);
                            }, child: Center(child: Text("الذهاب الي سلة المشتريات ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold),))),
                          ),
                        ],
                      ),
                    ));
                  },
                  child: Text(
                    "اضافه الي السلة",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],

      )
    );
  }
}




Widget defaultButton({
  double width =double.infinity,
  Color background=Colors.blue,
  Color colorText=Colors.white,
  double size =20,
  bool isUpperCase =true,
  double radius =0.0,
  Function function,
  double height:  40.0,
  @required String text,
}) => Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed:function,
    child: Text(
      isUpperCase? text.toUpperCase():text,
      style: TextStyle(
        color: colorText,
        fontSize:size,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
) ;

