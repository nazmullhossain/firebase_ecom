import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/main_provider/wishList_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class HeartButtonWidget extends StatelessWidget {
  const HeartButtonWidget({Key? key, required this.productId,  this.isInWishList=false}) : super(key: key);
final String productId;
final bool? isInWishList;
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    final Color color = Utils(context).color;

    final wishListProvider=Provider.of<WishListProvider>(context);
    // final bool?isInWishlist;
    return GestureDetector(
      onTap: () {
        final User? user=authInstance.currentUser;
        // print("User id is ${user!.uid}");
        if(user==null){
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Not user found. Please login first"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(14),
                        child: const Text("okay"),
                      ),
                    ),
                  ],
                );
              });
          return;
        }
        wishListProvider.addRemoveProductToWishList(productId: productId);
      },
      child: Icon(isInWishList != null &&isInWishList==true ?IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color: isInWishList !=null && isInWishList==true  ?Colors.red:color,
      ),
    );
  }
}
