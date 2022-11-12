import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/main_provider/cart_provider.dart';
import 'package:firecom/main_provider/products_provider.dart';
import 'package:firecom/models/cart_model.dart';
import 'package:firecom/models/products_models.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../main_provider/wishList_provider.dart';
import '../pages/product_details_page.dart';
import '../service/golobal_method.dart';
import '../utils/utils.dart';
import 'heart_button_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityTextContorller = TextEditingController();
  GlobalMethods golobalMethods = GlobalMethods();
  @override
  void initState() {
    _quantityTextContorller.text = widget.q.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextContorller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final productProvider = Provider.of<ProductProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final getCurrentProduct = productProvider.findProdById(cartModel.productId);
    double userPrice = getCurrentProduct.isOneSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;


    final wishListProvider=Provider.of<WishListProvider>(context);
    bool?_isInWishList=wishListProvider.getWishListItem.containsKey(getCurrentProduct.id);


    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsPage.routeName,
            arguments: cartModel.productId);

        // this code null error show  golobalMethods.navigateTo(context: context,routeName: ProductDetailsPage.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          color: color,
                          maxLines: 10,
                          textSize: 20,
                          text: getCurrentProduct.title,
                          isTitle: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                  fact: () {
                                    if (_quantityTextContorller.text == "1") {
                                      return;
                                    } else {
                                      setState(() {
                                        cartProvider.reducedQuantityByOne(
                                            cartModel.productId);
                                        _quantityTextContorller.text =
                                            (int.parse(_quantityTextContorller
                                                        .text) -
                                                    1)
                                                .toString();
                                      });
                                    }
                                  },
                                  icon: CupertinoIcons.minus,
                                  color: Colors.red),

                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextContorller,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide())),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"))
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        _quantityTextContorller.text = "1";
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),

                              _quantityController(
                                  fact: () {
                                    cartProvider.increaseQuantityByOne(
                                        cartModel.productId);
                                    setState(() {
                                      _quantityTextContorller.text = (int.parse(
                                                  _quantityTextContorller
                                                      .text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  icon: CupertinoIcons.plus,
                                  color: Colors.green),

                              // Flexible(
                              //   flex: 2,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Material(
                              //       color: color,
                              //       borderRadius: BorderRadius.circular(12),
                              //       child: InkWell(
                              //         borderRadius: BorderRadius.circular(12),
                              //      onTap: (){},
                              //         child: Icon(Icons.plus_one,color: Colors.white,) ,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cartProvider.removeOneItem(cartModel.productId);
                            },
                            child: Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          HeartButtonWidget(
                            productId: getCurrentProduct.id,
                            isInWishList: _isInWishList,
                          ),
                          TextWidget(
                              color: color,
                              maxLines: 1,
                              textSize: 18,
                              text: "\$${userPrice.toStringAsFixed(2)}")
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityController(
      {required VoidCallback fact,
      required IconData icon,
      required Color color}) {
    return Flexible(
      flex: 2,
      child: Padding(
        // padding: EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: fact,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
