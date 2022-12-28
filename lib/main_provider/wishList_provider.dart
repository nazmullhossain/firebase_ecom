import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/models/cart_model.dart';
import 'package:firecom/models/wishtList_model.dart';
import 'package:flutter/material.dart';

import '../consts/firebase_const.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> _wishListItem = {};

  //getter functon
  Map<String, WishListModel> get getWishListItem {
    return _wishListItem;
  }

//wishlist add and sub added
//   void addRemoveProductToWishList({required String productId}) {
//     if (_wishListItem.containsKey(productId)) {
//       removeOneItem(productId);
//     } else {
//       _wishListItem.putIfAbsent(
//           productId,
//           () => WishListModel(
//               id: DateTime.now().toString(), productId: productId));
//     }
//     notifyListeners();
//   }
// new code generate
  Future<void> removeOneItem({
    required String wishlistId,
    required String productId,
  }) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {
          'wishlistId': wishlistId,
          'productId': productId,
        }
      ])
    });
    _wishListItem.remove(productId);
    await fetchWishlist();
    notifyListeners();
  }



//   void removeOneItem(String productId) {
//     _wishListItem.remove(productId);
//     notifyListeners();
//   }



  Future<void> fetchWishlist() async {

    final userCollection = FirebaseFirestore.instance.collection('users');
    final User? user = authInstance.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get('userWish').length;
    for (int i = 0; i < leng; i++) {
      _wishListItem.putIfAbsent(
          userDoc.get('userWish')[i]['productId'],
              () => WishListModel(
            id: userDoc.get('userWish')[i]['wishlistId'],
            productId: userDoc.get('userWish')[i]['productId'],
          ));
    }
    notifyListeners();
  }



  Future<void> clearOnlineWishlist() async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': [],
    });
    _wishListItem.clear();
    notifyListeners();
  }

  void clearLocalWishlist() {
// new code generate
    void removeOneItem(String productId) {
      _wishListItem.remove(productId);
      notifyListeners();
    }


    void clearWishList() {
      _wishListItem.clear();
      notifyListeners();
    }
  }}