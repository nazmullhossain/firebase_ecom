import 'package:flutter/widgets.dart';

import '../models/products_models.dart';

class ProductProvider with ChangeNotifier{

  List<ProductModel>get getProducts{
    return _productsList;
  }

  List<ProductModel>get getOnSaleProduct{
    return _productsList.where((element) => element.isOneSale).toList();
  }

  //indivisuln product id and then show productDetailsPage
  ProductModel findProdById(String productId){
    return _productsList.firstWhere((element) => element.id==productId);
  }
  //catgory page
List<ProductModel>findByCatagory(String categoryName){
    List<ProductModel>_catagoryList=_productsList.
  where((element) => element.productCategoryName.toLowerCase().
    contains(categoryName.toLowerCase())).toList();
    return _catagoryList;
}

  static final List<ProductModel>_productsList=[

    ProductModel(
        title: "Apricot",
        price: 0.99,
        salePrice: 0.35,
        id: "1",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Vegitable",
        price: 0.99,
        salePrice: 0.35,
        id: "2",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Mango",
        price: 0.99,
        salePrice: 0.35,
        id: "3",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Bananana",
        price: 0.99,
        salePrice: 0.35,
        id: "4",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Avocado",
        price: 0.99,
        salePrice: 0.35,
        id: "5",
        imageUrl: "https://i.ibb.co/9VkXw5L/Avocat.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Panjabi",
        price: 0.99,
        salePrice: 0.35,
        id: "6",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Dog",
        price: 0.99,
        salePrice: 0.35,
        id: "7",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),
    ProductModel(
        title: "Jack Fruit",
        price: 0.99,
        salePrice: 0.35,
        id: "8",
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        isOneSale: false,
        isPiece: false,
        productCategoryName: "Fruits"),

  ];
}