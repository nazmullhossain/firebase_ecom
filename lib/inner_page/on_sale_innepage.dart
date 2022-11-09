import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../consts/slider_images.dart';
import '../utils/utils.dart';
import '../widgets/feed_items_widgets.dart';

class OnSaleInnerPage extends StatelessWidget {
  static const routeName = "/OnSaleInnerPage";
  const OnSaleInnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: _isEmty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset("images/box.png"),
                    ),
                    Text(
                      "No product on sale yet!,\nStay tuned",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              // shrinkWrap: true,
              // crossAxisSpacing: 10,

              // physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.70),
              children: List.generate(20, (index) {
                return FeedItemWidgets(title: SliderImage.productsList[index].title,
                  imageUrl: SliderImage.productsList[index].imageUrl,);
              }),
            ),
    );
  }
}
