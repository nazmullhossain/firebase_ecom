import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {Key? key,
      required this.price,
      required this.textPrice,
      required this.salePrice,
      required this.isOnSale})
      : super(key: key);
  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Size size = Utils(context).screenSize;
    final Color color = Utils(context).color;
    double userPrice = isOnSale ? salePrice : price;
    return Row(
      children: [
        TextWidget(
            color: Colors.green,
            maxLines: 10,
            textSize: 18,
            text: "\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}"
        ),
        SizedBox(
          width: 2,
        ),
        Visibility(
          visible: isOnSale? true:false,
          child: Text(
    "\$${(price * int.parse(textPrice)).toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 15,
                color: Colors.red,
                decoration: TextDecoration.lineThrough),
          ),
        )
      ],
    );
  }
}
