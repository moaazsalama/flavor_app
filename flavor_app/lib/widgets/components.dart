import 'package:flutter/material.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  bool isPassword =false,
   Function validate,
   String label,
   IconData prefix,
  IconData suffix,
  Function suffixPressed,
  double width=280  ,
  double height=45 ,
  String initial,
}) =>SizedBox(
  width: width,
  height: height,
  child:   TextFormField(
    initialValue:initial,

    onFieldSubmitted:onSubmit,

    onChanged: onChange,

    validator:validate,

    keyboardType: type,

    obscureText: isPassword,

    decoration: InputDecoration(



      labelText: label,

      prefixIcon: Icon(

        prefix,

      ),

      suffixIcon:suffix!=null? IconButton(

        onPressed:suffixPressed ,

        icon: Icon(

          suffix,

        ),

      ):null,

      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(10.0),

        ),

      ),


  ),
);

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

