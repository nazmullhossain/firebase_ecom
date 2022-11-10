import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier{
  final String id,title,imageUrl,productCategoryName;
  final double price, salePrice;
  final bool isOneSale,isPiece;

  ProductModel({
   required this.title,
   required this.price,
   required this.salePrice,
   required this.id,
   required this.imageUrl,
  required  this.isOneSale,
  required  this.isPiece,
   required this.productCategoryName
});

}