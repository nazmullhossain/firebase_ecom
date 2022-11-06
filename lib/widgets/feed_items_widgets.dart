import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/widgets/price_widget.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../utils/utils.dart';

class FeedItemWidgets extends StatefulWidget {
  const FeedItemWidgets({Key? key}) : super(key: key);

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
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
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
                    TextWidget(
                        color: color,
                        maxLines: 10,
                        textSize: 22,
                        text: "Title",
                        isTitle: true),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        IconlyLight.heart,
                        size: 22,
                        color: color,
                      ),
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
                     child: PriceWidget(price: 5.9,
                         textPrice: _quantityTextController.text,
                         salePrice: 2.99,
                         isOnSale: true),
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
                                text: "KG"),
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

             ElevatedButton(onPressed: (){}, child: Text("Add to Cart"))
            ],
          ),
        ),
      ),
    );
  }
}
