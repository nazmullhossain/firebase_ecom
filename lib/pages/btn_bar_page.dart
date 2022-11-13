import 'package:badges/badges.dart';
import 'package:firecom/main_provider/cart_provider.dart';
import 'package:firecom/pages/home_page.dart';
import 'package:firecom/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme-provider.dart';
import 'cart_page.dart';
import 'categories_page.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

final  List <Map<String,dynamic>>_page =[
  {"page": HomePage(),"title": "Home"},
  {"page": CategoriesPage(),"title": "Categories"},
  {"page": CartPage(),"title": "Cart"},
  {"page": UserPage(),"title": "User"},
];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    // final cartProvider=Provider.of<CartProvider>(context);
    bool _dark=themeState.getDarkTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(_page[_selectedIndex]["title"],),
      ),

      body: _page[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        selectedFontSize: 17.0,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed ,
        backgroundColor:
        _dark ? Theme.of(context).cardColor : Colors.red,
        onTap: _selectedPage,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Categories"),
          BottomNavigationBarItem(
              icon:
              Consumer<CartProvider>(
                builder: (context,myCart,ch) {
                  return Badge(
                      toAnimate: true,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: Text(myCart.getCartItem.length.toString(), style: TextStyle(color: Colors.white)),
                          child: Icon(_selectedIndex == 2 ? IconlyBold.bag : IconlyLight.buy));
                }
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user3 : IconlyLight.user2),
              label: "User"),
        ],
      ),
    );
  }
}





// import 'package:firecom/pages/cart_page.dart';
// import 'package:firecom/pages/home_page.dart';
// import 'package:firecom/pages/user_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
//
// import 'package:provider/provider.dart';
//
// import '../provider/dark_theme-provider.dart';
// import 'categories_page.dart';
//
//
// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }
//
// class _BottomBarScreenState extends State<BottomBarScreen> {
//   int _selectedIndex = 0;
//   final List<Map<String, dynamic>> _pages = [
//     {
//       'page': const HomePage(),
//       'title': 'Home Screen',
//     },
//     {
//       'page': CategoriesPage(),
//       'title': 'Categories Screen',
//     },
//     {
//       'page': const CartPage(),
//       'title': 'Cart Screen',
//     },
//     {
//       'page': const UserPage(),
//       'title': 'user Screen',
//     },
//   ];
//   void _selectedPage(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeState = Provider.of<DarkThemeProvider>(context);
//
//     bool _isDark = themeState.getDarkTheme;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text( _pages[_selectedIndex]['title']),
//       // ),
//       body: _pages[_selectedIndex]['page'],
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 2,
//         selectedFontSize: 17.0,
//         unselectedItemColor: Colors.white,
//         selectedItemColor: Colors.green,
//         type: BottomNavigationBarType.fixed ,
//         backgroundColor:
//         _isDark ? Theme.of(context).cardColor : Colors.red,
//         onTap: _selectedPage,
//         currentIndex: _selectedIndex,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//               icon: Icon(
//                   _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
//               label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(_selectedIndex == 1
//                   ? IconlyBold.category
//                   : IconlyLight.category),
//               label: "Categories"),
//           BottomNavigationBarItem(
//               icon:
//               Icon(_selectedIndex == 2 ? IconlyBold.bag : IconlyLight.buy),
//               label: "Cart"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                   _selectedIndex == 3 ? IconlyBold.user3 : IconlyLight.user2),
//               label: "User"),
//         ],
//       ),
//     );
//   }
// }
