import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../utils/utils.dart';

class BackWidgets extends StatelessWidget {
  const BackWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () =>
      Navigator.canPop(context) ? Navigator.pop(context) : null,
      child: Icon(
        IconlyLight.arrowLeft2,
        color: color,
        size: 24,
      ),
    );
  }
}
