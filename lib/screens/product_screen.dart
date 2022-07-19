import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ver2/providers/products.dart';

/// This is the stateless widget that the main application instantiates.
class ProductScreen extends StatelessWidget {
  static const String route="/ProductScreen";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
    Provider.of<Products>(context, listen: false).findItemById(productId);
    return Scaffold(

      body:Builder(

        builder: (context) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.network(
                      loadedProduct.imageUrl,
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text(
                            'ج.م',
                            maxLines: 1,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*2*/
                                Container(
                                  padding: const EdgeInsets.only(left: 65),
                                  child:  Text(
                                    loadedProduct.title,
                                    maxLines: 1,
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
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(left: 200),

                      child: Text(
                        'تقدم ساخنة *',
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
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
                                  Navigator.of(context).pop();
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
                                }, child: Center(child: Text("الذهاب الي سلة المشتريات ",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold),))),
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

          );
        }
      ),
    );
  }

}
