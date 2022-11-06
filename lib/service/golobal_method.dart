import 'package:flutter/material.dart';
class GlobalMethods{
   navigateTo({required BuildContext context, required String routeName}){
    Navigator.pushNamed(context, routeName);
  }
}