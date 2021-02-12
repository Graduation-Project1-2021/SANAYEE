import 'package:flutter/material.dart';
import 'package:flutterphone/Screens/Login/login_screen.dart';
import 'package:flutterphone/Screens/Signup/signup_screen.dart';
import 'package:flutterphone/Screens/Welcome/components/background.dart';
import 'package:flutterphone/components/rounded_button.dart';
import 'package:flutterphone/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterphone/screens/Signup/Sign_up.dart';
import 'package:flutterphone/screens/Signup/Sign_worker.dart';
import 'package:flutterphone/screens/Signup/Signup_Worker.dart';
import 'package:flutterphone/screens/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Body extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirebaseAuth.instance.signOut();
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 40),),
            SizedBox(height: size.height * 0.05),
            Image.asset("assets/icons/vc.jpg"),
            SizedBox(height: size.height * 0.05),
            Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 20),),
            RoundedButton(
              text: "تسجيل الدخول",
              color: Yellow,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "مقدم خدمة ؟ سجل هنا",
               color: Yellow,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Sign_Worker();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "إنشاء حساب جديد",
              color: Colors.deepPurple[100],
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
