import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/slider_images.dart';
import '../main_provider/products_provider.dart';
import '../models/products_models.dart';
import '../service/golobal_method.dart';
import '../utils/utils.dart';
import '../widgets/emty_product_widgets.dart';
import '../widgets/feed_items_widgets.dart';
import '../widgets/text_widgets.dart';

class CatagoryScreen extends StatefulWidget {
  const CatagoryScreen({Key? key}) : super(key: key);
  static const routeName = "/CatagoryScreen";

  @override
  State<CatagoryScreen> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {
  TextEditingController _serchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProductSearch=[];
  @override
  void dispose() {
    // TODO: implement dispose
    _serchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    final productProvider=Provider.of<ProductProvider>(context);
    final catagoryName=ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCatagory=productProvider.findByCatagory(catagoryName);

    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          color: color,
          maxLines: 10,
          textSize: 24,
          text: "Product on sale",
        ),
      ),
      body:productByCatagory.isEmpty?const EmtyProductWidget(text:"No product on sale yet!,\nStay tuned",): SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                  controller: _serchTextController,
                  onChanged: (value) {
                    setState(() {
                      listProductSearch=productProvider.searchQuery(value);
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.yellow, width: 2)),
                      hintText: "What is your mind",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                          onPressed: () {
                            _serchTextController.clear();
                            _searchTextFocusNode.unfocus();
                          },
                          icon: Icon(Icons.close,
                              color: _searchTextFocusNode.hasFocus
                                  ? Colors.red
                                  : color))),
                ),
              ),
            ),
        _serchTextController.text.isNotEmpty&&  listProductSearch.isEmpty?EmtyProductWidget(text: "No product found") : GridView.count(
              shrinkWrap: true,
              // crossAxisSpacing: 10,

              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.70),
              children: List.generate(
                  _serchTextController.text.isNotEmpty?
                      listProductSearch.length:
                  productByCatagory.length, (index) {
                return ChangeNotifierProvider.value(
                  value:_serchTextController.text.isNotEmpty?
                  listProductSearch[index]: productByCatagory[index],
                  child: const FeedItemWidgets(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
