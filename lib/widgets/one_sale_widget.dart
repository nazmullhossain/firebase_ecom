import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/main_provider/cart_provider.dart';
import 'package:firecom/models/products_models.dart';
import 'package:firecom/pages/product_details_page.dart';
import 'package:firecom/widgets/price_widget.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_const.dart';
import '../main_provider/wishList_provider.dart';
import '../service/golobal_method.dart';
import '../utils/utils.dart';
import 'heart_button_widget.dart';

class OneSaleWidget extends StatefulWidget {
  const OneSaleWidget({Key? key}) : super(key: key);

  @override
  State<OneSaleWidget> createState() => _OneSaleWidgetState();
}

class _OneSaleWidgetState extends State<OneSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final productModel=Provider.of<ProductModel>(context);
    final cartProvider=Provider.of<CartProvider>(context);
    final Utils utils=Utils(context);
    final themeState=utils.getTheme;
    final Size size=Utils( context).screenSize;
    // final productModel=Provider.of<ProductModel>(context);
    final Color color=Utils(context).color;
    // final productModel=Provider.of<ProductModel>(context);
    bool? _isInCart=cartProvider.getCartItem.containsKey(productModel.id);
    final wishListProvider=Provider.of<WishListProvider>(context);
    bool?_isInWishList=wishListProvider.getWishListItem.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor.withOpacity(0.9),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (){
                Navigator.pushNamed(context, ProductDetailsPage.routeName,arguments: productModel.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FancyShimmerImage(
                          imageUrl: productModel.imageUrl,
                          height: size.width*0.22,
                          width: size.width*0.22,
                          boxFit: BoxFit.fill,),
                        // Image.network("https://i.ibb.co/F0s3FHQ/Apricots.png",
                        // // width: size.width*0.22,
                        //   height: size.width*0.22,
                        //   fit: BoxFit.fill,
                        // ),
                        Column(
                          children: [
                            TextWidget(
                                color: color,
                                maxLines: 10,
                                textSize: 22,
                                text: productModel.isOneSale?"1Piece":"1KG",
                            isTitle:true),
                            SizedBox(height: 6,),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _isInCart? null: () async{

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

                                 await   GlobalMethods.addToCart(productId: productModel.id, quantity: 1, context: context);
                                    // cartProvider.addProductsToCart
                                    //   (productId: productModel.id,
                                    //     quantity: 1);
                                 await   cartProvider.fetchCart();
                                  },
                                  child: Icon(
                                    _isInCart?IconlyBold.bag2:IconlyLight.bag2,

                                  size: 22,color: _isInCart?Colors.green :color,),
                                ),
                                HeartButtonWidget(
                                  productId: productModel.id,
                                  isInWishList: _isInWishList,
                                )
                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                    PriceWidget(price: productModel.price,
                        textPrice: "1",
                        salePrice:productModel.salePrice,
                        isOnSale: true),
                    SizedBox(height: 3,),
                    TextWidget(color: color,
                        maxLines: 10, textSize:
                        16, text: productModel.title,
                        isTitle: true)

                  ],
                ),
              ),
            ),
      ),
    );
  }
}
