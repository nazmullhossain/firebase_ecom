import 'package:flutter/material.dart';

import '../utils/utils.dart';

class EmtyProductWidget extends StatelessWidget {
  const EmtyProductWidget({Key? key,required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color color=Utils(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset("images/box.png"),
            ),
            Text(
            text,
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
    );
  }
}
