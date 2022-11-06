import 'package:firecom/utils/utils.dart';
import 'package:flutter/material.dart';

import '../widgets/catagories_widget.dart';

class CategoriesPage extends StatelessWidget {
   CategoriesPage({Key? key}) : super(key: key);


   // List <Color> gridColor=[
   //   const Color(0xff53B175),
   //   const Color(0xffF8A44C),
   //   const Color(0xffF7A593),
   //   const Color(0xffD3B0E0),
   //   const Color(0xffB7DFF5),
   //   const Color(0xffB7DFF5),
   //
   // ];


   List<Color> gridColors = [
     const Color(0xff53B175),
     const Color(0xffF8A44C),
     const Color(0xffF7A593),
     const Color(0xffD3B0E0),
     const Color(0xffFDE598),
     const Color(0xffB7DFF5),
   ];

final List <Map<String,dynamic>> cartInfo=[
  {
    "imgPath": "images/fruits.png",
    "cartText": "Fruits"
  },

  {
    "imgPath": "images/veg.png",
    "cartText": "Vegetables"
  },

  {
    "imgPath": "images/Spinach.png",
    "cartText": "Herbs"
  },

  {
    "imgPath": "images/nuts.png",
    "cartText": "Nuts"
  },
  {
    "imgPath": "images/spices.png",
    "cartText": "Spices"
  },

  {
    "imgPath": "images/grains.png",
    "cartText": "Grains"
  },



];

  @override
  Widget build(BuildContext context) {
    final utils=Utils(context);
    Color color=utils.color;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
            crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio:  240/250,
          children: List.generate(cartInfo.length, (index) {
            return CatagoriesWidget(
                onPressed: (){},
                imgPath:cartInfo[index]["imgPath"],
                cartText: cartInfo[index]["cartText"],
                passColor: gridColors[index]);
          }),

        ),
      ),
    );
  }
}
