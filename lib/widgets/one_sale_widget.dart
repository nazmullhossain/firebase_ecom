import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/models/products_models.dart';
import 'package:firecom/pages/product_details_page.dart';
import 'package:firecom/widgets/price_widget.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class OneSaleWidget extends StatefulWidget {
  const OneSaleWidget({Key? key}) : super(key: key);

  @override
  State<OneSaleWidget> createState() => _OneSaleWidgetState();
}

class _OneSaleWidgetState extends State<OneSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final productModel=Provider.of<ProductModel>(context);
    final Utils utils=Utils(context);
    final themeState=utils.getTheme;
    final Size size=Utils( context).screenSize;
    // final productModel=Provider.of<ProductModel>(context);
    final Color color=Utils(context).color;
    // final productModel=Provider.of<ProductModel>(context);
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
                                  onTap: (){},
                                  child: Icon(IconlyLight.bag2,
                                  size: 22,color: color,),
                                ),
                                GestureDetector(
                                  onTap: (){},
                                  child: Icon(IconlyLight.heart,
                                  size: 22,color: color,),
                                ),
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
