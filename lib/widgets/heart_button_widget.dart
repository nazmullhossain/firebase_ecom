import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/main_provider/products_provider.dart';
import 'package:firecom/main_provider/wishList_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../main_provider/products_provider.dart';


import '../service/golobal_method.dart';
import '../utils/utils.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({Key? key, required this.productId,  this.isInWishList=false}) : super(key: key);
final String productId;
final bool? isInWishList;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.findProdById(widget.productId);
    final Utils utils = Utils(context);

    final Color color = Utils(context).color;

    final wishListProvider=Provider.of<WishListProvider>(context);
    // final productProvider=Provider.of<ProductProvider>(context);

    final getCurrrentProduct=productProvider.findProdById(widget.productId);

    // final bool?isInWishlist;
    return GestureDetector(

      onTap: () async{
        setState(() {
          loading=true;
        });

        try {
          final User? user = authInstance.currentUser;

          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: 'No user found, Please login first',
                context: context);
            return;
          }
          if (widget.isInWishList == false && widget.isInWishList != null) {
            await GlobalMethods.addToWishList(
                productId: widget.productId, context: context);
          } else {
     await   wishListProvider.removeOneItem(
    wishlistId: wishListProvider.getWishListItem[getCurrProduct.id]!.id,
    productId: widget.productId);
          }
          await wishListProvider.fetchWishlist();
          setState(() {
            loading=false;
          });

        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);

        } finally {
setState(() {
  loading=false;
});
        }



      // onTap: ()async {
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
      child:loading?SizedBox(height: 20,width: 20,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
      ): Icon(widget.isInWishList != null &&widget.isInWishList==true ?IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color: widget.isInWishList !=null && widget.isInWishList==true  ?Colors.red:color,
      ),
    );
  }
}
