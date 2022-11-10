import 'package:flutter/widgets.dart';

import '../models/products_models.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel>get getProducts{
    return _productsList;
  }

  static List<ProductModel>_productsList=[

    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "2424",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),

  ];
}