import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../widgets/text_widgets.dart';
class GlobalMethods{
   navigateTo({required BuildContext context, required String routeName}){
    Navigator.pushNamed(context, routeName);
  }


   static Future<void> warningDialog({
     required String title,
     required String subtitle,
     required Function fct,
     required BuildContext context,
   }) async {
     await showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Row(children: [
               Image.asset(
                 'images/warning-sign.png',
                 height: 20,
                 width: 20,
                 fit: BoxFit.fill,
               ),
               const SizedBox(
                 width: 8,
               ),
               Text(title),
             ]),
             content: Text(subtitle),
             actions: [
               TextButton(
                 onPressed: () {
                   if (Navigator.canPop(context)) {
                     Navigator.pop(context);
                   }
                 },
                 child: TextWidget(
                   color: Colors.cyan,
                   text: 'Cancel',
                   textSize: 18, maxLines: 1,
                 ),
               ),
               TextButton(
                 onPressed: () {
                   fct();
                   if (Navigator.canPop(context)) {
                     Navigator.pop(context);
                   }
                 },
                 child: TextWidget(
                   color: Colors.red,
                   text: 'OK',
                   textSize: 18, maxLines: 1,
                 ),
               ),
             ],
           );
         });
   }

   static Future<void> errorDialog({
     required String subtitle,
     required BuildContext context,
   }) async {
     await showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Row(children: [
               Image.asset('images/warning-sign.png',


                 height: 20,
                 width: 20,
                 fit: BoxFit.fill,
               ),
               const SizedBox(
                 width: 8,
               ),
               const Text('An Error occured'),
             ]),
             content: Text(subtitle),
             actions: [
               TextButton(
                 onPressed: () {
                   if (Navigator.canPop(context)) {
                     Navigator.pop(context);
                   }
                 },
                 child: TextWidget(
                   color: Colors.cyan,
                   text: 'Ok',
                   textSize: 18, maxLines: 1,
                 ),
               ),
             ],
           );
         });
   }













   static Future<void>addToCart({required String productId,
  required int quantity,
  required BuildContext context})async{
     User?user=authInstance!.currentUser;
     final _uid=user!.uid;
     final cartId=Uuid().v4();
     try{
FirebaseFirestore.instance.collection("users").doc(_uid).update({
"userCart":FieldValue.arrayUnion([
  {
    "cartId": cartId,
    'productId':productId,
    "quantity": quantity
  }
])
});
     }catch(error){
       Fluttertoast.showToast(
           msg: "error show ${error.toString()}",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
  }



//add to wish list data
   static Future<void>addToWishList({
     required String productId,

     required BuildContext context})async{
     User?user=authInstance!.currentUser;
     final _uid=user!.uid;
     final wishlistId=Uuid().v4();
     try{
       FirebaseFirestore.instance.collection("users").doc(_uid).update({
         "userWish":FieldValue.arrayUnion([
           {
             "wishlistId": wishlistId,
             'productId':productId,

           }
         ])
       });
       Fluttertoast.showToast(
           msg: "Item has been added to your wishlist",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }catch(error){
       Fluttertoast.showToast(
           msg: "error show ${error.toString()}",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
   }


}