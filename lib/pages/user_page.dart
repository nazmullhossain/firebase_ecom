import 'package:firecom/pages/viewed/viewed_page.dart';
import 'package:firecom/pages/viewed/viewed_widgets.dart';
import 'package:firecom/pages/wishlist/wishlist_page.dart';
import 'package:firecom/service/golobal_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme-provider.dart';
import '../widgets/text_widgets.dart';
import 'order/order_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  static const routeName = "/ViewedPage";

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  GlobalMethods golobalMethod=GlobalMethods();
  final TextEditingController _addressController=TextEditingController(text: "");

  @override
  void dispose() {
    _addressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final themeState= Provider.of<DarkThemeProvider>(context);
    Color color=themeState.getDarkTheme?Colors.white:Colors.black;
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              RichText(text: const TextSpan(
                text: "Hi"  ,style: TextStyle(color: Colors.cyan,
              fontWeight: FontWeight.bold,fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: "My Name", style: TextStyle(color: Colors.cyan,
                  fontWeight: FontWeight.bold,fontSize: 20),)
                ]
              )
              ),

              const SizedBox(height: 20,),
              const Divider(
                thickness: 2,
              ),
              SizedBox(height: 20,),
              _listTile(
                  color: color,
                  title: "Address",
                  subTitle: "SubTitle here",
                  leadingIcon: (IconlyLight.profile),
                  trailingIcon: IconlyLight.arrowRight2,
                  onPressed: () async {
                 await   _addressDialog();
                  } ),
              _listTile(
                  color: color,
                  title: "Orders",
                  leadingIcon: (IconlyLight.bag),
                  trailingIcon: IconlyLight.arrowRight2,
                  onPressed: () {
                    golobalMethod.navigateTo(context: context, routeName: OrderPage.routeName);
                  }),

              _listTile(
                  color: color,
                  title: "Wishlist",
                  leadingIcon: (IconlyLight.heart),
                  trailingIcon: IconlyLight.arrowRight2,
                  onPressed: () {
                    golobalMethod.navigateTo(context: context, routeName: WishListPage.routeName);
                  }),
              _listTile(
                  title: "Forget Password",
                  leadingIcon: (IconlyLight.unlock),
                  color: color,
                  trailingIcon: IconlyLight.arrowRight2,
                  onPressed: () {}),

              _listTile(
                  title: "Viewed",
                  color: color,
                  leadingIcon: (IconlyLight.show),
                  trailingIcon: IconlyLight.arrowRight2,
                  onPressed: () {
                    golobalMethod.navigateTo(context: context, routeName: ViewedPage.routeName);
                  }),
              SwitchListTile(
                title: TextWidget(color: color, maxLines: 10, textSize: 18, text: themeState.getDarkTheme?"Dark Mode": "Light Mode"),
                secondary: Icon(themeState.getDarkTheme
                    ?Icons.dark_mode_outlined:Icons.light_mode_outlined),
                onChanged: (bool value){
                  setState(() {
                    themeState.setDarkTheme=value;
                  });
                },
                value: themeState.getDarkTheme,
              ),

              _listTile(
                  color: color,
                  title: "Logout",
                  leadingIcon: (IconlyLight.logout),
                  trailingIcon: IconlyLight.arrowRight2,
                  onPressed: () async{
                    await showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Row(
                          children: [
                            Image.asset('images/warning-sign.png',fit: BoxFit.cover,width: 20,height: 20,),
                            Text("Singout")
                          ],
                        ),
                        content: Text("Are you wannna singout??"),

                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("cancel")),
                          TextButton(onPressed: (){}, child: Text("ok")),

                        ],
                      );
                    });
                  }
                  ),
            ],
        ),
      ),
    ),
        ));
  }
Future <void> _addressDialog() async{
  await showDialog(context: context, builder: (context){
    return AlertDialog(

      title: Text("Update"),
      content: TextField(
        controller: _addressController,
        onChanged: ( value){

        },
        // maxLines: 5,
        decoration: const InputDecoration(
            hintText: "Your address"
        ),

      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancel")),
        // SizedBox(width: 10,),
        TextButton(onPressed: (){
          print(_addressController.text);
        }, child: Text("Save"))
      ],
    );
  });
}


  Widget _listTile(
      {required String title,
        required Color color,
      String? subTitle,
      required IconData leadingIcon,
      required IconData trailingIcon,
      required VoidCallback onPressed}) {
    return ListTile(
      onTap: onPressed,
      title: TextWidget(color: color, maxLines: 10,
          textSize: 18, text: title),
      subtitle: TextWidget(color: color,
          isTitle: true,
          maxLines: 10 ,
          textSize: 18,
          text: subTitle==null? "":subTitle),
      leading: Icon(leadingIcon),
      trailing: Icon(trailingIcon),
    );
  }
}
