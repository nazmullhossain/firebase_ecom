import 'package:flutter/cupertino.dart';

class WishListModel  with ChangeNotifier {
  final String id, productId;

  WishListModel({
    required this.id,
    required this.productId,

  });
}