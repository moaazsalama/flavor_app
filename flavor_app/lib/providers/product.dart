
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  int points;
  int isDrinks;
  int isFood;
  int isOffer;
  int isFasting;

  Product({
    
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.points,
    @required this.isFood,
    @required this.isDrinks,
    @required this.isOffer,
    @required this.isFasting,
    @required this.imageUrl,
  });
}
