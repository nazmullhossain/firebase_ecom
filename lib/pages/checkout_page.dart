import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/pages/btn_bar_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../consts/firebase_const.dart';
import '../consts/slider_images.dart';
import '../pages/fetch_page.dart';
import '../pages/loading_manager_page.dart';
import '../service/golobal_method.dart';
import '../utils/utils.dart';
import '../widgets/auth_button.dart';
import '../widgets/google_button_widgets.dart';
import '../widgets/text_widgets.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);
  static const routeName = "/RegisterPage";

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalMethods globalMethods = GlobalMethods();
  late bool _obSecure = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();


  final _emailFocusNode = FocusNode();
  final _adddressFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  bool _isLoading = false;
  @override
  void dispose() {

    _fullNameController.dispose();

    _addressController.dispose();
    _phoneNumberController.dispose();




    // TODO: implement dispose
    super.dispose();
  }
  //authentication method
// final FirebaseAuth auth=FirebaseAuth.instance;
  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {

        //firestore database
        final User? user=authInstance.currentUser;
        final _uid=user!.uid;

        await FirebaseFirestore.instance.collection("orders")
            .doc(_uid).set({
          "id": _uid,
          "name": _fullNameController.text,

          "shipping_address": _addressController.text,
       "phone_number": _phoneNumberController.text,
          "createdAt": Timestamp.now(),

        });




        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => FetchPage()));
        print("successfully");
      } on FirebaseException catch (error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("your have occured ${error.message}"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay"),
                    ),
                  ),
                ],
              );
            });
        setState(() {
          _isLoading = false;
        });

        print("have occured ${error}");
      } catch (error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("your have occured ${error}"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay"),
                    ),
                  ),
                ],
              );
            });
        setState(() {
          _isLoading = false;
        });

        print("have occured ${error}");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    return Scaffold(
      body: LoadingManger(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              duration: 800,
              autoplayDelay: 6000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  SliderImage.offerImage[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: SliderImage.offerImage.length,
              // pagination: const SwiperPagination(
              //     alignment: Alignment.bottomCenter,
              //     builder: DotSwiperPaginationBuilder(
              //       color: Colors.white,
              //       activeColor: Colors.red,
              //
              //     )
              // ),
              // control: SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    TextWidget(
                        color: Colors.white,
                        maxLines: 1,
                        textSize: 30,
                        text: "Welcome Back"),
                    const SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                        color: Colors.white,
                        maxLines: 1,
                        textSize: 18,
                        text: "Sign in to continue"),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //name
                            TextFormField(
                              controller: _fullNameController,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please enter your name";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "name",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white)),
                              ),
                            ),

                            //email

                            const SizedBox(
                              height: 12,
                            ),

                            //phone number filed field

                            TextFormField(
                              focusNode: _adddressFocusNode,
                              controller: _addressController,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () => _submitFormOnRegister(),
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please enter your city";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Shipping address",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              focusNode: _phoneNumberFocusNode,
                              controller: _phoneNumberController,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => _submitFormOnRegister(),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "please enter your phone number";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white)),
                              ),
                            ),



                            //adresss
                            // TextFormField(
                            //   focusNode: _adddressFocusNode,
                            //   controller: _addressController,
                            //   textInputAction: TextInputAction.done,
                            //   onEditingComplete: () => _submitFormOnRegister(),
                            //   keyboardType: TextInputType.streetAddress,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return "please enter your city";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   style: const TextStyle(color: Colors.white),
                            //   decoration: const InputDecoration(
                            //     hintText: "Shipping address",
                            //     hintStyle: TextStyle(color: Colors.white),
                            //     enabledBorder: UnderlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.white)),
                            //     focusedBorder: UnderlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.white)),
                            //   ),
                            // ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // _isLoading
                    //     ? Center(child: const CircularProgressIndicator()):
                    AuthButtonWidget(
                      buttonText: "  Check Out",
                      onPressed: () {
                        _submitFormOnRegister();
                      },
                    ),



                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
