import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/main_provider/products_provider.dart';
import 'package:firecom/main_provider/wishList_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../service/golobal_method.dart';
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
    final productProvider=Provider.of<ProductProvider>(context);

    final getCurrrentProduct=productProvider.findProdById(productId);

    // final bool?isInWishlist;
    return GestureDetector(
      onTap: ()async {
      // try{
      //   final User?user=authInstance.currentUser;
      //   if(user==null){
      //     GlobalMethods.errorDialog(
      //         subtitle: "No user found, please login first",
      //         context: context);
      //     return;
      //   }
      //   if(isInWishList==false && isInWishList !=null){
      //  await   GlobalMethods.addToWishList(productId: productId, context: context);
      //
      //   }else{
      //  await   wishListProvider.removeOneItem(productId: productId,
      //         userWish: wishListProvider.getWishListItem[getCurrrentProduct.id]!.id);
      //   }
      //  await wishListProvider.fetchWishListData();
      //
      // }catch(error){
      //
      // }finally{
      //
      // }
        // wishListProvider.addRemoveProductToWishList(productId: productId);
      },
      child: Icon(isInWishList != null &&isInWishList==true ?IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color: isInWishList !=null && isInWishList==true  ?Colors.red:color,
      ),
    );
  }
}
