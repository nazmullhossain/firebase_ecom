import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/slider_images.dart';
import '../main_provider/products_provider.dart';
import '../models/products_models.dart';
import '../utils/utils.dart';
import '../widgets/emty_product_widgets.dart';
import '../widgets/feed_items_widgets.dart';
import '../widgets/one_sale_widget.dart';

class OnSaleInnerPage extends StatelessWidget {
  static const routeName = "/OnSaleInnerPage";
  const OnSaleInnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productProviders=Provider.of<ProductProvider>(context);
    List<ProductModel>allProduct=productProviders.getProducts;


    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    bool _isEmty = false;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          color: color,
          maxLines: 10,
          textSize: 24,
          text: "Product on sale",
        ),
      ),
      body: allProduct.isEmpty
          ? EmtyProductWidget(text:"No product on sale yet!,\nStay tuned",)
          : GridView.count(
              // shrinkWrap: true,
              // crossAxisSpacing: 10,

              // physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.70),
              children: List.generate(allProduct.length, (index) {
                return ChangeNotifierProvider.value(
                  value: allProduct[index],
                  child: OneSaleWidget(
                    ),
                );
              }),
            ),
    );
  }
}
