import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
       this.primary=Colors.white38})
      : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
          ),
          onPressed: onPressed, child: Text(buttonText,style: TextStyle(
        color: Colors.white,fontSize: 18
      ),)),
    );
  }
}
