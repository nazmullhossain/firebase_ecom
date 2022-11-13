import 'package:firecom/emty_page.dart';
import 'package:firecom/main_provider/viewedProvider.dart';
import 'package:firecom/pages/viewed/viewed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

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
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedItemList =
        viewedProvider.getViewedItem.values.toList().reversed.toList();
    return viewedItemList.isEmpty
        ? EmtyPage(
            buttonText: "Shop now",
            imagePath: "images/history.png",
            whoopsSubtitleText: "No Products has been viewed yet",
            whoopsText: "Your history is emty")
        : Scaffold(
            appBar: AppBar(
              leading: BackWidgets(),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                  color: color,
                  maxLines: 1,
                  textSize: 20,
                  text: "Viewed (${viewedItemList.length})"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Image.asset(
                                    'images/warning-sign.png',
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text("Singout")
                                ],
                              ),
                              content: Text("Your Viewed is clear????"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("cancel")),
                                TextButton(onPressed: () {
                                  viewedProvider.clearHistory();


                                  if(Navigator.canPop(context)){
                                    Navigator.pop(context);
                                  }




                                }, child: Text("ok")),
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: Colors.red,
                    ))
              ],
            ),

            body: ListView.separated(

                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: viewedItemList[index],
                      child: ViewedWidget());
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: color,
                  );
                },
                itemCount: viewedItemList.length),
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
