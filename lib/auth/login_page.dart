import 'package:card_swiper/card_swiper.dart';
import 'package:firecom/auth/register_page.dart';
import 'package:firecom/service/golobal_method.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../consts/slider_images.dart';
import '../pages/forget_password.dart';
import '../widgets/auth_button.dart';
import '../widgets/google_button_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "/LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  GlobalMethods globalMethods=GlobalMethods();
  late bool _obSecure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passFocusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _submitFormOnLogin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print("The form is valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          TextFormField(
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
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
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
                            onEditingComplete: () {
                              _submitFormOnLogin();
                            },
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
                            decoration:  InputDecoration(
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _obSecure =!_obSecure;
                                  });
                                },
                                  child: Icon(_obSecure?Icons.visibility: Icons.visibility_off,color: Colors.white,)),
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: (){
                      globalMethods.navigateTo(context: context, routeName: ForgetPasswordPage.routeName);
                    }, child: const Text("Foreet pasword?",style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic
                    ),)),
                  ),
                  SizedBox(height: 10,),
                  
                  AuthButtonWidget(buttonText: "Login In", onPressed: (){
                    _submitFormOnLogin();
                  }, ),
                  SizedBox(height: 10,),
                  GoogleButtonWidgets(),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      )),
                      SizedBox(width: 5,),
                      TextWidget(color: Colors.white, maxLines: 1, textSize: 18, text: "OR"),
                      SizedBox(width: 5,),
                      Expanded(child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      )),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  AuthButtonWidget(buttonText: "Continue as a gusest", onPressed: (){},primary: Colors.black,),
                  const SizedBox(height: 10,),
                  RichText(text:  TextSpan(text: "Dont\t have an account?",style: TextStyle(color: Colors.white,fontSize: 18),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=(){
                        globalMethods.navigateTo(context: context, routeName: RegisterPage.routeName);
                      },
                        text: "   Sign Up",style: TextStyle(color: Colors.lightBlue,fontSize: 18))
                  ]
                  )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
