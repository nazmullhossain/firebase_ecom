import 'package:firecom/emty_page.dart';
import 'package:firecom/pages/wishlist/wishlist_widgets.dart';
import 'package:firecom/widgets/cart_widget.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../main_provider/wishList_provider.dart';
import '../../utils/utils.dart';
import '../../widgets/back_widgets.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);
  static const routeName = "/WishListPage";

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishlistItemsList =
        wishListProvider.getWishListItem.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? EmtyPage(
            buttonText: "Add a wish",
            imagePath: "images/wishlist.png",
            whoopsSubtitleText: "Explore more and shortlist some items",
            whoopsText: "your wishlsit is emty")
        : Scaffold(
            appBar: AppBar(
              leading: BackWidgets(),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                  color: color,
                  maxLines: 1,
                  textSize: 20,
                  text: "WishList (${wishlistItemsList.length})"),
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
                                  Text("Wishlist")
                                ],
                              ),
                              content: Text("Your wishlist will be cleard??"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("cancel")),
                                TextButton(
                                    onPressed: () {
                                      wishListProvider.clearWishList();
                                      if(Navigator.canPop(context)){
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text("ok")),
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
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   centerTitle: true,
            //   title: TextWidget(
            //       color: Colors.black,
            //       maxLines: 1,
            //       textSize: 22,
            //       text: "WishList (2)"),
            //   elevation: 0,
            //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            //   leading: BackWidgets(),
            //   actions: [
            //     IconButton(onPressed: () {}, icon: Icon(IconlyBroken.delete))
            //   ],
            // ),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index], child: WishListWidget());
              },
            ),
          );
  }
}
