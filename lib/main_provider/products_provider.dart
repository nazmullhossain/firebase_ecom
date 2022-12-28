import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../models/products_models.dart';

class ProductProvider with ChangeNotifier{
static  List<ProductModel> _productsList=[];
  List<ProductModel>get getProducts{
    return _productsList;
  }

  List<ProductModel>get getOnSaleProduct{
    return _productsList.where((element) => element.isOneSale).toList();
  }

  Future<void>fetchProduct()async{
    final firestore=FirebaseFirestore.instance;
  await  firestore.collection("products").get().then((QuerySnapshot productSnapshot) {
_productsList=[];
// _productsList.clear();
    productSnapshot.docs.forEach((element) {
  _productsList.insert(0, ProductModel(
      title: element.get('title'),
      price: double.parse(element.get('price'),),
      salePrice: element.get('salePrice'),
      id: element.get('id'),
      imageUrl: element.get('imageUrl'),
      isOneSale: element.get('isOnSale'),
      isPiece: element.get('isPiece'),
      productCategoryName: element.get('productCategoryName')));
});
  });
  notifyListeners();
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
//search by product title
List<ProductModel>searchQuery(String searchText){
  List<ProductModel>_searchList=_productsList.
  where((element) => element.title.toLowerCase().
  contains(searchText.toLowerCase())).toList();
  return _searchList;
}

  // static final List<ProductModel>_productsList=[
  //
  //   ProductModel(
  //       title: "Apricot",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "1",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Vegitable",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "2",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Mango",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "3",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Bananana",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "4",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Avocado",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "5",
  //       imageUrl: "https://i.ibb.co/9VkXw5L/Avocat.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Panjabi",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "6",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Dog",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "7",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //   ProductModel(
  //       title: "Jack Fruit",
  //       price: 0.99,
  //       salePrice: 0.35,
  //       id: "8",
  //       imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
  //       isOneSale: false,
  //       isPiece: false,
  //       productCategoryName: "Fruits"),
  //
  // ];
}