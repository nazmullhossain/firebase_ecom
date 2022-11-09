import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../emty_page.dart';
import '../utils/utils.dart';
import '../widgets/cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _cartPage=false;
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(onPressed: (){}, icon: Icon(IconlyBold.delete
        //     ))
        //   ],
        // ),
        body: _cartPage? EmtyPage(buttonText: 'Browse All',
            imagePath: "images/cart.png",
            whoopsSubtitleText: "your have not add to card",
            whoopsText: "WhoopsText"): Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(color: color, maxLines: 1, textSize: 22, text: "Cart(2)",isTitle: true,),
              IconButton(onPressed: () async{
                await showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Row(
                      children: [
                        Image.asset('images/warning-sign.png',fit: BoxFit.cover,width: 20,height: 20,),
                        Text("Singout")
                      ],
                    ),
                    content: Text("Your wishlist will be cleard??"),

                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("cancel")),
                      TextButton(onPressed: (){}, child: Text("ok")),

                    ],
                  );
                });
              }, icon: Icon(IconlyBroken.delete)),

                // SizedBox(width: 20,)
            ],

          ),


        ),
        Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height *0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(color: Colors.white,
                            maxLines: 1,
                            textSize: 20,
                            text: 'Order Now',),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: TextWidget(color: color,
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return CartWidget();
              }),
        ),
      ],
    ));
  }
}
