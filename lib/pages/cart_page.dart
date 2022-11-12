import 'package:firecom/main_provider/cart_provider.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../emty_page.dart';
import '../utils/utils.dart';
import '../widgets/cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    bool _cartPage = false;
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList = cartProvider.getCartItem.values.toList().reversed.toList();
    return Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(onPressed: (){}, icon: Icon(IconlyBold.delete
        //     ))
        //   ],
        // ),
        body: cartItemList.isEmpty
            ? EmtyPage(
                buttonText: 'Browse All',
                imagePath: "images/cart.png",
                whoopsSubtitleText: "your have not add to card",
                whoopsText: "WhoopsText")
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          color: color,
                          maxLines: 1,
                          textSize: 22,
                          text: "Cart(${cartItemList.length})",
                          isTitle: true,
                        ),
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Image.asset(
                                            'images/warning-sign.png',
                                            fit: BoxFit.cover,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text("Cart")
                                        ],
                                      ),
                                      content: Text(
                                          "Your Cart will be cleard??"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("cancel")),
                                        TextButton(
                                            onPressed: () {
                                              cartProvider.clearCart();

                                              if(Navigator.canPop(context)){
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text("ok")),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(IconlyBroken.delete)),

                        // SizedBox(width: 20,)
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextWidget(
                                      color: Colors.white,
                                      maxLines: 1,
                                      textSize: 20,
                                      text: 'Order Now',
                                    ),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: TextWidget(
                                  color: color,
                                  maxLines: 1,
                                  textSize: 18,
                                  text: "Total: \$0.259",
                                  isTitle: true,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartItemList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: cartItemList[index],
                              child: CartWidget(q:  cartItemList[index].quantity,));
                        }),
                  ),
                ],
              ));
  }
}
