import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class ViewedWidget extends StatelessWidget {
  const ViewedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return ListTile(
      trailing: Container(
        // height: size.height*0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red
        ),
        child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.plus)),
      ),
      title: TextWidget(color: color, maxLines: 1, textSize: 20, text: "Title",isTitle: true),
      subtitle: TextWidget(color: color, maxLines: 1, textSize: 16, text: "\$12.88"),

      leading: Container(
        height: size.height*0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),


        ),
        child:  FancyShimmerImage(
          imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
          boxFit: BoxFit.scaleDown,
          width: size.width *0.2,
        ),
      ),

    );
  }
}
