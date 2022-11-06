import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class GoogleButtonWidgets extends StatelessWidget {
  const GoogleButtonWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "images/google.png",
                width: 40.0,
              ),
            ),
            SizedBox(width: 8,),
            TextWidget(color: Colors.white, maxLines: 1, textSize: 18, text: "Sign in with Google")
          ],
        ),
      ),
    );
  }
}
