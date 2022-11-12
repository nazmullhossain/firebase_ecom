import 'package:firecom/models/cart_model.dart';
import 'package:firecom/models/wishtList_model.dart';
import 'package:flutter/material.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> _wishListItem = {};

  //getter functon
  Map<String, WishListModel> get getWishListItem {
    return _wishListItem;
  }

//wishlist add and sub added
  void addRemoveProductToWishList({required String productId}) {
    if (_wishListItem.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishListItem.putIfAbsent(
          productId,
          () => WishListModel(
              id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _wishListItem.remove(productId);
    notifyListeners();
  }

  void clearWishList() {
    _wishListItem.clear();
    notifyListeners();
  }
}
