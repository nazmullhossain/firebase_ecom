import 'package:firecom/consts/theme_data.dart';
import 'package:firecom/pages/btn_bar_page.dart';
import 'package:firecom/pages/forget_password.dart';
import 'package:firecom/pages/home_page.dart';
import 'package:firecom/pages/order/order_page.dart';
import 'package:firecom/pages/product_details_page.dart';
import 'package:firecom/pages/viewed/viewed_page.dart';
import 'package:firecom/pages/wishlist/wishlist_page.dart';
import 'package:firecom/provider/dark_theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'emty_page.dart';
import 'inner_page/catagor_screen.dart';
import 'inner_page/feed_innerpage.dart';
import 'inner_page/on_sale_innepage.dart';
import 'main_provider/cart_provider.dart';
import 'main_provider/products_provider.dart';
import 'main_provider/viewedProvider.dart';
import 'main_provider/wishList_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //screen orientiation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        //product_provider
        ChangeNotifierProvider(create: (_)=>ProductProvider()),

//cart provider
        ChangeNotifierProvider(create: (_)=>CartProvider()),
        //wishlist provider
        ChangeNotifierProvider(create: (_)=>WishListProvider()),
        ChangeNotifierProvider(create: (_)=>ViewedProvider()),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: BottomBarPage(),
          routes: {
            OnSaleInnerPage.routeName:(context)=>OnSaleInnerPage(),
            FeedInnerPage.routeName:(context)=>FeedInnerPage(),
            ProductDetailsPage.routeName:(context)=>ProductDetailsPage(),
            WishListPage.routeName:(context)=>WishListPage(),
            OrderPage.routeName:(context)=>OrderPage(),
            ViewedPage.routeName:(context)=>ViewedPage(),
            RegisterPage.routeName:(context)=>RegisterPage(),
            LoginPage.routeName:(context)=>const LoginPage(),
            ForgetPasswordPage.routeName:(context)=>const ForgetPasswordPage(),
            CatagoryScreen.routeName:(context)=>const      CatagoryScreen(),
            // CatagoryScreen.routeName:(context)=>const      CatagoryScreen(),


            // EmtyPage.routeName:(context)=>EmtyPage(),

          },
        );
      }),
    );
  }
}
