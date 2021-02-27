import 'package:flutter/gestures.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/signworker_screen.dart';
import 'package:flutterphone/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutterphone/Inside_the_app/inside.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/components/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'login_screen.dart';
String IP4="192.168.1.8";
String _verificationCode;
String smscode ;
FocusNode myFocusNode = new FocusNode();

class WelcomeScreen extends StatefulWidget {
  @override

  _Body createState() => _Body();
}

class _Body extends State<WelcomeScreen> {

  @override
  final formKey = new GlobalKey<FormState>();
  bool login=false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Color(0xFF1C1C1C),
        body: Form(key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                GestureDetector(
                  onTap: () {
                    setState(() {
                      login = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    height: login ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6,
                    child: CustomPaint(
                      painter: CurvePainter(login),
                      child: Container(
                        padding: EdgeInsets.only(bottom: login ? 0 : 55),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child:Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top:45,right: 240),
                                    padding: EdgeInsets.only(left: 5,right:5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFF1C1C1C),
                                      ),
                                    ),
                                    child:GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context) => Loginscreen()));
                                        },
                                        child:Text('تسجيل الدخول',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1C1C1C),
                                            // decoration: TextDecoration.underline,
                                            fontFamily: 'Changa',),)

                                    ),),
                                  Container(
                                    margin: EdgeInsets.only(top: 35,),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      // color:Color(0xFF1C1C1C),
                                      image: DecorationImage(
                                        image: new AssetImage(
                                          'assets/icons/vb.png',
                                        ),
                                      ),),),
                                  Container(
                                      child:Text('صنايعي ',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1C1C1C),
                                          fontFamily: 'Changa',
                                          fontStyle: FontStyle.italic,
                                        ),)
                                  ),
                                  Stack(
                                    children:[
                                      Container(
                                          margin: EdgeInsets.only(top:25),
                                          child:Text(' تطبيق صنايعي هو تطبيق يقدم العديد من الخدمات المنزلية كنجار وكهربائي وحداد ... سجل معنا الآن لتتلقى جميع خدمات صنايعي ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1C1C1C),
                                              fontFamily: 'Changa',
                                            ),)
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top:85,right: 190),
                                        child:GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (BuildContext context) => SignuserScreen()));
                                            },
                                            child:Text('سجّل معنا',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1C1C1C),
                                                decoration: TextDecoration.underline,
                                                fontFamily: 'Changa',),)

                                        ),),],),

                                  // Container(
                                  //     child:Text('هل أنت مقدم خدمة؟ سجل معنا الآن ',
                                  //       style: TextStyle(
                                  //         fontSize: 25,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.grey[600],
                                  //         fontFamily: 'Changa',
                                  //       ),)
                                  // )
                                ],),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      login = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                    height: login ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.4,
                    child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(top: login ? 55 : 0),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child:Column(
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(top:45,right: 120),
                                    padding: EdgeInsets.only(left: 5,right:5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFF3D657),
                                      ),
                                    ),
                                    child:GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context) => SignWorker()));
                                        },
                                        child:Text('مقدم خدمة سجّل هنا؟',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFF3D657),
                                            // decoration: TextDecoration.underline,
                                            fontFamily: 'Changa',),)

                                    ),),
                                  Container(
                                    // child:IconButton(
                                    //
                                    // ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ),

              ],

            ),),
        ),),);
  }
}
class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFF3D657);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}