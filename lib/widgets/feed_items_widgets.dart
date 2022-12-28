import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/main_provider/wishList_provider.dart';
import 'package:firecom/models/cart_model.dart';
import 'package:firecom/models/products_models.dart';
import 'package:firecom/pages/product_details_page.dart';
import 'package:firecom/widgets/price_widget.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_const.dart';
import '../main_provider/cart_provider.dart';
import '../service/golobal_method.dart';
import '../utils/utils.dart';
import 'heart_button_widget.dart';

class FeedItemWidgets extends StatefulWidget {
  const FeedItemWidgets({Key? key,}) : super(key: key);


  @override
  State<FeedItemWidgets> createState() => _FeedItemWidgetsState();
}

class _FeedItemWidgetsState extends State<FeedItemWidgets> {
  final TextEditingController _quantityTextController=TextEditingController();

  @override
  void initState() {
    _quantityTextController.text="1";
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _quantityTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
final productModel=Provider.of<ProductModel>(context);
final cartProvider=Provider.of<CartProvider>(context);
bool?_isInCart=cartProvider.getCartItem.containsKey(productModel.id);
final wishListProvider=Provider.of<WishListProvider>(context);
bool?_isInWishList=wishListProvider.getWishListItem.containsKey(productModel.id);

    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsPage.routeName,
            arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width * 0.21,
                width: size.width * 0.2,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex:3,
                      child: TextWidget(
                          color: color,
                          maxLines: 1,
                          textSize: 18,
                          text: productModel.title,
                          isTitle: true),
                    ),
                    Flexible(
                      flex: 1,
                      child:HeartButtonWidget(
                        productId: productModel.id,
                      isInWishList: _isInWishList,
                      )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Flexible(
                     flex:4,
                     child: PriceWidget(
                         price: productModel.price,
                         textPrice: _quantityTextController.text,
                         salePrice: productModel.salePrice,
                         isOnSale: productModel.isOneSale),
                   ),
                    SizedBox(width: 2,),
                    Flexible(
                      child: Row(
                        children: [
                          FittedBox(
                            child: TextWidget(
                                color: color,
                                maxLines: 1,
                                textSize: 10,
                                isTitle: true,
                                text: productModel.isPiece?"Pices": "KG"),
                          ),
                          SizedBox(width: 3,),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _quantityTextController,
                              onChanged: (value){
                            setState(() {
                            if(value.isEmpty){
                              _quantityTextController.text="1";
                            }
                            else{
                              return;
                            }
                            });
                              },
                              key: ValueKey(10),
                              style: TextStyle(
                            color: color,
                            fontSize: 8,

                              ),
                              keyboardType: TextInputType.number,
                            maxLines: 1,
                              enabled: true,
                              inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

             ElevatedButton(onPressed: _isInCart?null: () async{
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

               await   GlobalMethods.addToCart(productId: productModel.id, quantity: int.parse(_quantityTextController.text), context: context);
         await   cartProvider.fetchCart();
               // cartProvider.addProductsToCart
               //   (productId: productModel.id,
               //     quantity: int.parse(_quantityTextController.text));
             }, child: Text( _isInCart?"প্রডাক্ট যোগ হয়েছে":  "Add to Cart"))
            ],
          ),
        ),
      ),
    );
  }
}
