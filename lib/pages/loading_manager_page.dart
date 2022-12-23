import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingManger extends StatelessWidget {
  const LoadingManger({Key? key,required this.isLoading,required this.child}) : super(key: key);

   final bool isLoading;
    final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        child,
        isLoading?Container(
          color: Colors.black.withOpacity(0.7),
        ):
            Container(

            ),
        isLoading? const Center(
          child: SpinKitSquareCircle(
            color: Colors.white,
            size: 50.0,
            // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
          )
        ):
            Container()
      ],
    );
  }
}
