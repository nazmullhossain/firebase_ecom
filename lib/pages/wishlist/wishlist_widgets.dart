import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../service/golobal_method.dart';
import '../../utils/utils.dart';
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: (){
          golobalMethods.navigateTo(context: context, routeName: ProductDetailsPage.routeName);
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
                  Container(
                    // color: Colors.red,
                    margin: EdgeInsets.only(left: 8),
                    width: size.width *0.2,
                    height: size.width*0.25,
                    child:     FancyShimmerImage(
                      imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
                      height: size.width * 0.21,
                      width: size.width * 0.2,
                      boxFit: BoxFit.fill,
                    ),
                  ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){},
                          icon: Icon(IconlyLight.bag2,color: color,)),
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
                  Flexible(
                      child: TextWidget(color: color,
                          maxLines: 1,
                          textSize: 20,
                          text: "Title",
                        isTitle: true,
                      )),
      SizedBox(height: 5,),

      TextWidget(color: color,
      maxLines: 1,
      textSize: 18,
      text: "\$2.59",
      isTitle: true,
      ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
