import 'package:firecom/models/cart_model.dart';
import 'package:firecom/models/wishtList_model.dart';
import 'package:flutter/material.dart';

import '../models/viewModel.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedModel> _viewedItem = {};

  //getter functon
  Map<String, ViewedModel> get getViewedItem {
    return _viewedItem;
  }

//wishlist add and sub added
  void addProductToHistory({required String productId}) {

      _viewedItem.putIfAbsent(
          productId,
              () => ViewedModel(
              id: DateTime.now().toString(), productId: productId));

    notifyListeners();
  }



  void clearHistory() {
    _viewedItem.clear();
    notifyListeners();
  }
}
