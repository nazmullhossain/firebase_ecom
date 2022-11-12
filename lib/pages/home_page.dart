import 'package:card_swiper/card_swiper.dart';
import 'package:firecom/models/products_models.dart';
import 'package:firecom/provider/dark_theme-provider.dart';
import 'package:firecom/service/golobal_method.dart';
import 'package:firecom/utils/utils.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/slider_images.dart';
import '../inner_page/feed_innerpage.dart';
import '../inner_page/on_sale_innepage.dart';
import '../main_provider/products_provider.dart';
import '../widgets/feed_items_widgets.dart';
import '../widgets/one_sale_widget.dart';
import '../widgets/product_title_widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> _offerImage=[
  //   "images/Offer1.jpg",
  //   "images/Offer2.jpg",
  //   "images/Offer3.jpg",
  //   "images/Offer4.jpg",
  // ];
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModel> allProduct = productProviders.getProducts;
    List<ProductModel> onSaleProduct = productProviders.getOnSaleProduct;
    GlobalMethods globalMethods = GlobalMethods();
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.33,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  SliderImage.offerImage[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: SliderImage.offerImage.length,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  )),
              // control: SwiperControl(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                // globalMethods.navigateTo(context: context,routeName: OnSaleInnerPage.routeName);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnSaleInnerPage()),
                );
              },
              child: Text("View all")),
          Row(
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(
                        color: Colors.red,
                        maxLines: 10,
                        textSize: 22,
                        text: "On Sale".toUpperCase(),
                        isTitle: true),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      IconlyLight.discount,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: size.height * 0.24,
                  child: ListView.builder(
                      itemCount:
                          allProduct.length < 10 ? allProduct.length : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: allProduct[index], child: OneSaleWidget());
                      }),
                ),
              ),
            ],
          ),
          ProductTitleWidget(
              productTitle: "Product All",
              viewTitle: "Select All",
              viewButton: () {
                // globalMethods.navigateTo(context: context,routeName: FeedInnerPage.routeName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedInnerPage()),
                );
              }),
          SizedBox(
            height: 2,
          ),
          GridView.count(
            shrinkWrap: true,
            // crossAxisSpacing: 10,

            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: size.width / (size.height * 0.70),
            children: List.generate(
                allProduct.length < 4 ? allProduct.length : 4, (index) {
              return ChangeNotifierProvider.value(
                value: allProduct[index],
                child: FeedItemWidgets(),
              );
            }),
          )
        ],
      ),
    ));
  }
}
