import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firecom/consts/firebase_const.dart';
import 'package:firecom/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/btn_bar_page.dart';

class GoogleButtonWidgets extends StatelessWidget {
   GoogleButtonWidgets({Key? key}) : super(key: key);
  bool _isLoading=false;

  //google singn in method
Future<void>_googleSignIn(context)async{
  final googleSignIn=GoogleSignIn();
  final googleAcount=await googleSignIn.signIn();
  if(googleAcount!=null){
  final googleAuth=await googleAcount.authentication;
  if(googleAuth.accessToken!=null && googleAuth.idToken !=null){
    try{
      await authInstance.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
        )
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomBarPage()));
    }on FirebaseException catch (error){
print("Somthing error ${error.message}");
    }catch(error){
      print("Somthing error ${error}");
    }finally{

    }
  }
  }
}
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "images/google.png",
                width: 40.0,
              ),
            ),
            SizedBox(width: 8,),
            TextWidget(color: Colors.white, maxLines: 1, textSize: 18, text: "Sign in with Google")
          ],
        ),
      ),
    );
  }
}
