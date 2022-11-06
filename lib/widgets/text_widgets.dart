import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
   TextWidget({Key? key,
  required this.color,
     this.isTitle=false,
    required this.maxLines,
    required this.textSize,
    required this.text

  }) : super(key: key);
final String text;
final Color color;
final double textSize;
bool isTitle;
int maxLines=10;

  @override
  Widget build(BuildContext context) {
    return Text(

      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: textSize,
        fontWeight:isTitle? FontWeight.bold: FontWeight.normal,
        color: color,

      ),
    );
  }
}
