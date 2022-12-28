import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
   Map<String,CartModel>_cartItem={};

   //getter functon
    Map<String,CartModel> get getCartItem{
      return _cartItem;

  }

  //add to cart this method
  void addProductsToCart({
  required String productId,
    required int quantity,
}){
    _cartItem.putIfAbsent(productId, () => CartModel(
      id: DateTime.now().toString(),
      productId: productId,
      quantity: quantity
    ));
    notifyListeners();
}

Future<void> fetchCart()async{
      final User? user=authInstance.currentUser;
      final _uid=user!.uid;
      final DocumentSnapshot userDoc=
          await FirebaseFirestore.instance
      .collection("users").doc(_uid).get();
      if(userDoc==null){
        return;
      }
final len=userDoc.get('userCart').length;
      for(int i=0; i<len; i++){
        _cartItem.putIfAbsent(userDoc.get('userCart')[i]['productId'], () => CartModel(
            id: userDoc.get('userCart')[i]['cartId'],
            productId: userDoc.get('userCart')[i]['productId'],
            quantity: userDoc.get('userCart')[i]['quantity']
        ));
      }
      notifyListeners();

}



void reducedQuantityByOne(String productId){
      _cartItem.update(productId, (value) => CartModel(
          id: value.id,
          productId: productId,
          quantity: value.quantity -1));
      notifyListeners();

}

   void increaseQuantityByOne(String productId){
     _cartItem.update(productId, (value) => CartModel(
         id: value.id,
         productId: productId,
         quantity: value.quantity +1));
     notifyListeners();



   }


 Future<void>   removeOneItem({
    required String productId,
   required String cartId,
   required int qunaitty
   })async{
     final User? user=authInstance.currentUser;
     final _uid=user!.uid;
      await FirebaseFirestore.instance.collection("users")
     .doc(_uid).update({
        "userCart": FieldValue.arrayRemove([
          {
            "cartId": cartId,
            'productId':productId,
            'quantity': qunaitty
          }
        ])
      });
      _cartItem.remove(productId);
      await fetchCart();
      notifyListeners();
   }

   Future<void>clearOnlineCart()async{
      User? user=authInstance.currentUser;
     final _uid=user!.uid;

     FirebaseFirestore.instance.collection("users").doc(_uid).update({
       "userCart":[]

     });
      _cartItem.clear();
      notifyListeners();
}
   void clearLocalCart( ){
     _cartItem.clear();
     notifyListeners();
   }



}