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
