import 'package:firecom/pages/viewed/viewed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../utils/utils.dart';
import '../../widgets/back_widgets.dart';
import '../../widgets/text_widgets.dart';

class ViewedPage extends StatelessWidget {
  const ViewedPage({Key? key}) : super(key: key);
  static const routeName = "/ViewedPage";

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(
      appBar: AppBar(
        leading: BackWidgets(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(color: color, maxLines: 1, textSize: 20, text: "WishList (2)"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            await showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Row(
                  children: [
                    Image.asset('images/warning-sign.png',fit: BoxFit.cover,width: 20,height: 20,),
                    Text("Singout")
                  ],
                ),
                content: Text("Your Viewed is clear????"),

                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("cancel")),
                  TextButton(onPressed: (){}, child: Text("ok")),

                ],
              );
            });
          }, icon: Icon(IconlyBroken.delete,color: Colors.red,))
        ],
      ),

      body: ListView.separated(itemBuilder: (context,index){
        return ViewedWidget();
      }, separatorBuilder: (BuildContext context,int index){
        return Divider(color: color,);
      }, itemCount: 10),
      // body: ListView.separated(
      //     itemBuilder: (context,index){
      //       return ViewedWidget();
      //     },
      //     separatorBuilder: (BuildContext context,int index){
      //       return Divider(
      //         color: color,
      //       );
      //     },
      //     itemCount: 10),
    );
  }
}
