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
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "/RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalMethods globalMethods = GlobalMethods();
  late bool _obSecure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _adddressFocusNode = FocusNode();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _emailFocusNode.dispose();
    _adddressFocusNode.dispose();
    _passFocusNode.dispose();

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
        await authInstance.createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        //firestore database
        final User? user=authInstance.currentUser;
        final _uid=user!.uid;

        await FirebaseFirestore.instance.collection("users")
        .doc(_uid).set({
          "id": _uid,
          "name": _fullNameController.text,
          "email": _emailController.text,
          "password":_passwordController.text,
          "shipping_address": _addressController.text,
          "userWish": [],
          "userCart": [],
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
                            TextFormField(
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "please enter valid your email address";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "email",
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

                            //password field
                            TextFormField(
                              obscureText: _obSecure,
                              focusNode: _passFocusNode,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {},
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return "please enter valid your password";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obSecure = !_obSecure;
                                      });
                                    },
                                    child: Icon(
                                      _obSecure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                            //adresss
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
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Foreet pasword?",
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // _isLoading
                    //     ? Center(child: const CircularProgressIndicator()):
                    AuthButtonWidget(
                      buttonText: "  Sign up",
                      onPressed: () {
                        _submitFormOnRegister();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // GoogleButtonWidgets(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                            color: Colors.white,
                            maxLines: 1,
                            textSize: 18,
                            text: "OR"),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // AuthButtonWidget(buttonText: "Continue as a gusest", onPressed: (){},primary: Colors.black,),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "All ready a user?",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // globalMethods.navigateTo(context: context, routeName: LoginPage.routeName);
                                  // Navigator.canPop(context)?Navigator.pop(context):null;
                                  // Navigator.pushReplacement(context, LoginPage.routeName);

                                  // Navigator.pushReplacement<void, void>(
                                  //   context,
                                  //   MaterialPageRoute<void>(
                                  //     builder: (BuildContext context) => const LoginPage(),
                                  //   ),
                                  // );
                                },
                              text: "   Sign in",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 18))
                        ]))
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
