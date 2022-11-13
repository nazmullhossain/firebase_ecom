import 'package:firecom/service/golobal_method.dart';
import 'package:firecom/utils/utils.dart';
import 'package:flutter/material.dart';

import 'inner_page/feed_innerpage.dart';

class EmtyPage extends StatelessWidget {
  EmtyPage(
      {Key? key,
      required this.buttonText,
      required this.imagePath,
      required this.whoopsSubtitleText,
      required this.whoopsText})
      : super(key: key);
  static const routeName = "/EmtyPage";
  String imagePath, whoopsText, whoopsSubtitleText, buttonText;

  @override
  Widget build(BuildContext context) {
    GlobalMethods golobalMethod = GlobalMethods();
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: size.height * 0.4,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              whoopsText,
              style: TextStyle(
                  color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              whoopsSubtitleText,
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  golobalMethod.navigateTo(
                      context: context, routeName: FeedInnerPage.routeName);
                },
                child: Text(buttonText))
          ],
        ),
      ),
    );
  }
}
