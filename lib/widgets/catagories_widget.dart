import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme-provider.dart';

class CatagoriesWidget extends StatelessWidget {
   CatagoriesWidget({Key? key,
     required this.onPressed,
     required this.imgPath,
     required this.cartText,
     required this.passColor

   }) : super(key: key);
  VoidCallback onPressed;
  final String cartText,imgPath;
  final Color passColor;

  @override
  Widget build(BuildContext context) {
    final themeState= Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme? Colors.white: Colors.black;
    double _screenWidth=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPressed,
      child: Container(
        // height: _screenWidth*0.6,
        decoration: BoxDecoration(
          color: passColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16 ),
          border: Border.all(
            color: passColor.withOpacity(0.7),
            width: 2
          )
        ),
        child: Column(
          children: [
            Container(
              height: _screenWidth*0.3 ,
              width: _screenWidth*0.3 ,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath),fit: BoxFit.fill,)
              ),
            ),
            TextWidget(color: color, maxLines: 10, textSize: 20, text: cartText,isTitle: true)
          ],
        ),
      ),
    );
  }
}
