import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/main_provider/wishList_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../main_provider/products_provider.dart';
import '../service/golobal_method.dart';
import '../utils/utils.dart';

class HeartButtonWidget extends StatelessWidget {
  const HeartButtonWidget({Key? key, required this.productId,  this.isInWishList=false}) : super(key: key);
final String productId;
final bool? isInWishList;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.findProdById(productId);
    final Utils utils = Utils(context);

    final Color color = Utils(context).color;

    final wishListProvider=Provider.of<WishListProvider>(context);
    // final bool?isInWishlist;
    return GestureDetector(
      onTap: () async{

        try {
          final User? user = authInstance.currentUser;

          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: 'No user found, Please login first',
                context: context);
            return;
          }
          if (isInWishList == false && isInWishList != null) {
            await GlobalMethods.addToWishList(
                productId: productId, context: context);
          } else {
     await   wishListProvider.removeOneItem(
    wishlistId: wishListProvider.getWishListItem[getCurrProduct.id]!.id,
    productId: productId);
          }
          await wishListProvider.fetchWishlist();

        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {

        }



      },
      child: Icon(isInWishList != null &&isInWishList==true ?IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color: isInWishList !=null && isInWishList==true  ?Colors.red:color,
      ),
    );
  }
}
