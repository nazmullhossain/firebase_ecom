import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/service/golobal_method.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../product_details_page.dart';

class OrderWidgets extends StatefulWidget {
  const OrderWidgets({Key? key}) : super(key: key);

  @override
  State<OrderWidgets> createState() => _OrderWidgetsState();
}

class _OrderWidgetsState extends State<OrderWidgets> {
  GlobalMethods _globalMethods=GlobalMethods();
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return ListTile(
      subtitle: Text("Paid: \$12.8"),
      onTap: (){
        _globalMethods.navigateTo(context: context,
            routeName: ProductDetailsPage.routeName);
      },
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: FancyShimmerImage(
          imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
          boxFit: BoxFit.scaleDown,
          width: size.width *0.2,
        ),
      ),
      title: TextWidget(color: color,
          maxLines: 1, textSize: 18,
          text: "Title x12"),
      trailing: TextWidget(color: color,
          maxLines: 1,
          textSize: 18, text: "3/08/2022"),
    );
  }
}
