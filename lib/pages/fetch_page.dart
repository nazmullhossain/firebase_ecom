import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/main_provider/cart_provider.dart';
import 'package:firecom/pages/btn_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../consts/slider_images.dart';
import '../main_provider/products_provider.dart';

class FetchPage extends StatefulWidget {
  const FetchPage({Key? key}) : super(key: key);

  @override
  State<FetchPage> createState() => _FetchPageState();
}

class _FetchPageState extends State<FetchPage> {
  List<String> images=SliderImage.authImagesPath;
  @override
  void initState() {
    images.shuffle();
    // TODO: implement initState
 Future.delayed(Duration(milliseconds: 5),()async{
   final productProvider=Provider.of<ProductProvider>(context,listen: false);
   final cartProvider=Provider.of<CartProvider>(context,listen: false);
   final User?user=authInstance.currentUser;
   if(user==null){
     await productProvider.fetchProduct();
     cartProvider.clearLocalCart();
   }
   else{
     await productProvider.fetchProduct();
     await cartProvider.fetchCart();
   }

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomBarPage()));
 });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(images[0],
          fit: BoxFit.cover,
          height: double.infinity,),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: SpinKitSquareCircle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
