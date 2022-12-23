import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/auth/login_page.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/pages/loading_manager_page.dart';
import 'package:firecom/pages/viewed/viewed_page.dart';
import 'package:firecom/pages/viewed/viewed_widgets.dart';
import 'package:firecom/pages/wishlist/wishlist_page.dart';
import 'package:firecom/service/golobal_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme-provider.dart';
import '../widgets/text_widgets.dart';
import 'forget_password.dart';
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
bool _isLoading =false;
String? _email;
String? _name;
String? _address;
  final User? user=authInstance.currentUser;
  @override
  void dispose() {
    _addressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Future<void>getData()async{
setState(() {
  _isLoading=true;
});
if(user==null){
  setState(() {
    _isLoading=false;
  });
  return;
}
try{
String _uid=user!.uid;
final DocumentSnapshot userDoc= await FirebaseFirestore.instance.collection("users")
.doc(_uid).get();
if(userDoc==null){
  return;
}else{
  _email=userDoc.get("email");
  _name=userDoc.get("name");
  _address=userDoc.get("shipping_address");
  _addressController.text=userDoc.get("shipping_address");
}


}catch(error){
  setState(() {
    _isLoading=false;

  });
  Fluttertoast.showToast(
      msg: "Firebase error ${error}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );

}finally{
setState(() {
  _isLoading=false;
});
}
  }

  // final User? user=authInstance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeState= Provider.of<DarkThemeProvider>(context);
    Color color=themeState.getDarkTheme?Colors.white:Colors.black;
    return Scaffold(
        body: LoadingManger(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                RichText(text:  TextSpan(
                  text: "Hi"  ,style: const TextStyle(color: Colors.cyan,
                fontWeight: FontWeight.bold,fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(text: _name==null? "user": _name, style: const TextStyle(color: Colors.cyan,
                    fontWeight: FontWeight.bold,fontSize: 20),),
                    // TextSpan(text: _name==null? "user": _name, style: const TextStyle(color: Colors.cyan,
                    // fontWeight: FontWeight.bold,fontSize: 20),),
                  ]
                )
                ),
Text(_email==null?"email":_email!),
                const SizedBox(height: 20,),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(height: 20,),
                _listTile(
                    color: color,
                    title: "Address",
                    subTitle: _address==null?"address": _address!,
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgetPasswordPage()));
                    }),

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
                    title:user==null?"Login":  "Logout",
                    leadingIcon: ( user==null?IconlyLight.login: IconlyLight.logout),
                    trailingIcon: IconlyLight.arrowRight2,
                    onPressed: () async{
                      if(user==null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()
                        )
                        );
                        return;
                      }
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
                            TextButton(onPressed: (){

                              authInstance.signOut();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>LoginPage()));
                            }, child: Text("ok")),

                          ],
                        );
                      });
                    }
                    ),
              ],
          ),
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
        TextButton(onPressed: ()async{
          String _uid=user!.uid;
          //how to update data
          try{
            await FirebaseFirestore.instance
                .collection("users")
                .doc(_uid).update({
              "shipping_address":_addressController.text
            });
            Navigator.pop(context);
            //when your update then pop and show updated data
            setState(() {
_address=_addressController.text;
            });
          }catch(error){
            print(error);
          }
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
