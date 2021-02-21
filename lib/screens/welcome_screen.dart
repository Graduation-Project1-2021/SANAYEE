import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/Worker/profile_page.dart';
import 'package:flutterphone/components/rounded_button.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/signworker_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 's.dart';
class WelcomeScreen extends StatefulWidget {
  @override

  _Body createState() => _Body();
}

class _Body extends State<WelcomeScreen> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    //FirebaseAuth.instance.signOut();
    // This size provide us total height and width of our screen
    return  Scaffold(
      body: new Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        // Container(
        // height: size.height,
        //   width: double.infinity,
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: <Widget>[
        //       Positioned(
        //         top: 0,
        //         left: 0,
        //         child: Image.asset(
        //           "assets/images/main_top.png",
        //           width: size.width * 0.3,
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         left: 0,
        //         child: Image.asset(
        //           "assets/images/main_bottom.png",
        //           width: size.width * 0.2,
        //         ),
        //       ),
        //     ],
        //   ),
        //  ),
            Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 40),),
            Container(
              // margin: EdgeInsets.all(40),
              child:Image.asset("assets/images/welcom.jpg"),
            ),
            SizedBox(height: size.height * 0.0525),
            Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 20),),
            RoundedButton(
              text: "تسجيل الدخول",
              color: Yellow,
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
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
                      return SignWorker();
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
                      return SignuserScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),);
  }
}