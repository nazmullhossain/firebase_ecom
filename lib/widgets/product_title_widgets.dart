import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class ProductTitleWidget extends StatelessWidget {
  const ProductTitleWidget({Key? key,required this.productTitle, required this.viewTitle, required this.viewButton}) : super(key: key);
 final String productTitle,viewTitle;
 final VoidCallback viewButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: (){}, child: TextWidget(
              color: Colors.orange,
              maxLines: 10,
              textSize: 20, text: productTitle,isTitle:true)),
          TextButton(onPressed: viewButton, child: TextWidget(
              color: Colors.orange,
              maxLines: 10,
              textSize: 20, text: viewTitle,isTitle:true)),
        ],
      ),
    );
  }
}
