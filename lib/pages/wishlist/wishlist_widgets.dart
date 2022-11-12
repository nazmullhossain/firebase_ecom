import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/main_provider/products_provider.dart';
import 'package:firecom/models/wishtList_model.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../main_provider/wishList_provider.dart';
import '../../service/golobal_method.dart';
import '../../utils/utils.dart';
import '../../widgets/heart_button_widget.dart';
import '../product_details_page.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalMethods golobalMethods=GlobalMethods();
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final wishListModel=Provider.of<WishListModel>(context);
    final productProvider=Provider.of<ProductProvider>(context);

    final getCurrentProduct = productProvider.findProdById(wishListModel.productId);
    // bool?_isInWishList=wishListProvider.getWishListItem.containsKey(.id);
    double userPrice = getCurrentProduct.isOneSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
     final wishListProvider=Provider.of<WishListProvider>(context);
    bool?_isInWishList=wishListProvider.getWishListItem.containsKey(getCurrentProduct.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: (){
         Navigator.pushNamed(context, ProductDetailsPage.routeName,
         arguments: wishListModel.productId);
          // golobalMethods.navigateTo(context: context, routeName: ProductDetailsPage.routeName);
        },
        child: Container(
        height:  size.height*0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.5),

            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color,width: 1),

          ),
          child: Row(
            children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(left: 8),
                      // width: size.width *0.2,
                      height: size.width*0.25,
                      child:     FancyShimmerImage(
                        imageUrl: getCurrentProduct.imageUrl,
                        height: size.width * 0.21,
                        width: size.width * 0.2,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                  ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){},
                            icon: Icon(IconlyLight.bag2,color: color,)),
                        HeartButtonWidget(
                          productId: getCurrentProduct.id,
                          isInWishList: _isInWishList,
                        ),
                      ],
                    ),
                    TextWidget(color: color,
                        maxLines: 1,
                        textSize: 20,
                        text: getCurrentProduct.title,
                      isTitle: true,
                    ),
      SizedBox(height: 5,),

      TextWidget(color: color,
      maxLines: 1,
      textSize: 18,
      text: "\$${userPrice.toStringAsFixed(2)}",
      isTitle: true,
      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
