import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../consts/slider_images.dart';
import '../utils/utils.dart';
import '../widgets/auth_button.dart';
import '../widgets/text_widgets.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);
  static const routeName = "/ForgetPasswordPage";

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _emailController=TextEditingController();
  late bool _obSecure = true;
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void _forgetPasFCT() async{

  }
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
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
                    height:50,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: (){
                      Navigator.canPop(context)?Navigator.pop(context):null;
                    },
                    child: Icon(IconlyLight.arrowLeft2,
                    color: Colors.white,),
                  ),
                  SizedBox(height: 80,),
                  TextWidget(
                      color: Colors.white,
                      maxLines: 1,
                      textSize: 30,
                      text: "Forget Password"),
                  const SizedBox(
                    height: 8,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.done,

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

                    ],
                  ),


                  SizedBox(height: 10,),

                  AuthButtonWidget(buttonText: "Reset Now", onPressed: (){

                  }, ),






                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
