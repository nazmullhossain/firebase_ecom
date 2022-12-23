import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/main_provider/cart_provider.dart';
import 'package:firecom/main_provider/products_provider.dart';
import 'package:firecom/models/viewModel.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_const.dart';
import '../../utils/utils.dart';

class ViewedWidget extends StatelessWidget {
  const ViewedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final productProvider = Provider.of<ProductProvider>(context);
    final viewedModel = Provider.of<ViewedModel>(context);
    final getCurrentProduct =
        productProvider.findProdById(viewedModel.productId);
    double userPrice = getCurrentProduct.isOneSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart =
        cartProvider.getCartItem.containsKey(getCurrentProduct.id);



    return ListTile(
      trailing: Container(
        // height: size.height*0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.red),
        child: IconButton(onPressed:_isInCart?null: () {
          final User? user=authInstance.currentUser;
          print("User id is ${user!.uid}");
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


          cartProvider.addProductsToCart(
              productId: getCurrentProduct.id,
              quantity: 1);
        },
            icon: Icon(_isInCart?
            Icons.check

            :IconlyBold.plus
            )),
      ),
      title: TextWidget(
          color: color,
          maxLines: 1,
          textSize: 20,
          text: getCurrentProduct.title,
          isTitle: true),
      subtitle:
          TextWidget(color: color, maxLines: 1, textSize: 16, 
              text: "\$${userPrice.toStringAsFixed(2)}"),
      leading: Container(
        height: size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: FancyShimmerImage(
          imageUrl: getCurrentProduct.imageUrl,
          boxFit: BoxFit.scaleDown,
          width: size.width * 0.2,
        ),
      ),
    );
  }
}
