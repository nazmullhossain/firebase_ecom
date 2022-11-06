import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../utils/utils.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
  }) : super(key: key);

  static const routeName = "/ProductDetailsPage";

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  TextEditingController _quantityTextConroller =
      TextEditingController(text: '1');
  @override
  void dispose() {
    _quantityTextConroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
@override
  void initState() {
    // TODO: implement initState
  _quantityTextConroller.text="1";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              Navigator.canPop(context) ? Navigator.pop(context) : null,
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
              boxFit: BoxFit.scaleDown,
              width: size.width,
            ),
          ),
          Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: TextWidget(
                                  color: color,
                                  maxLines: 1,
                                  textSize: 18,
                                  text: "Title")),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              IconlyLight.heart,
                              size: 22,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                              color: Colors.green,
                              maxLines: 1,
                              textSize: 18,
                              text: "\$2.59"),
                          TextWidget(
                              color: color,
                              maxLines: 1,
                              textSize: 12,
                              text: "/kg"),
                          SizedBox(
                            width: 10,
                          ),
                          Visibility(
                              visible: true,
                              child: Text(
                                "\$3.9",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: color,
                                    decoration: TextDecoration.lineThrough),
                              )),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(63, 200, 101, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextWidget(
                                color: color,
                                maxLines: 1,
                                textSize: 16,
                                text: "Free Delivery",

                                isTitle: true),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _quantityController(
                            fact: () {
                              if(_quantityTextConroller.text=="1"){
                                return;
                              }
                              else{
                                setState(() {
                                  _quantityTextConroller.text=(int.parse(_quantityTextConroller.text)-1).toString();
                                });
                              }
                            },
                            icon: CupertinoIcons.minus_square,
                            color: Colors.red),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextConroller.text = "1";
                                  } else {
                                    return;
                                  }
                                });
                              },
                              controller: _quantityTextConroller,
                              key: ValueKey("quantity"),
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              textAlign: TextAlign.center,
                              cursorColor: Colors.green,
                              enabled: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                            )),
                        _quantityController(
                            fact: () {
                              setState(() {
                                _quantityTextConroller.text=(int.parse(_quantityTextConroller.text)+1).toString();
                              });
                            },
                            icon: CupertinoIcons.plus_square,
                            color: Colors.green),

                        //
                        // _quantityController(
                        //     fact: () {
                        //       setState(() {
                        //         _quantityTextConroller.text=(int.parse(_quantityTextConroller.text)+1).toString();
                        //       });
                        //     },
                        //     icon: CupertinoIcons.plus,
                        //     color: Colors.green),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  color: Colors.red.shade300,
                                  maxLines: 1,
                                  textSize: 20,
                                  text: "Total"),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                        color: color,
                                        maxLines: 1,
                                        textSize: 20,
                                        text: "\$2.59/"),
                                    TextWidget(
                                        color: color,
                                        maxLines: 1,
                                        textSize: 16,
                                        text: "${_quantityTextConroller.text}kg")
                                  ],
                                ),
                              )
                            ],
                          )),
                          SizedBox(width: 8,),
                          Flexible(
                              child: Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextWidget(color: Colors.white,
                                        maxLines: 1, textSize: 18
                                        , text: "Add to Cart"),
                                  ),
                                )
                                ,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _quantityController(
      {required VoidCallback fact,
      required IconData icon,
      required Color color}) {
    return Flexible(
      flex: 2,
      child: Padding(
        // padding: EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: fact,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
