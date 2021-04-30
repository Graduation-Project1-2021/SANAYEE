import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/signworker_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphone/components/pin_entry_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import '../Map.dart';
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
  bool login=true;
  int _currentIndex=0;

  List cardList=[
    Item1(),
    Item2(),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  CarouselSlider cslider;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // Timer(Duration(milliseconds: 6000), () {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => Loginscreen(),
    //       ));
    // });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Stack(
        children: [

          Container(
              decoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.8),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.black54.withOpacity(0.35),
                      BlendMode.dstATop),
                  image: new AssetImage(
                    'assets/work/cv.jpg',
                  ),
                ),
              )

            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/work/background.jpg'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
            //   child: Container(
            //     color: Colors.black.withOpacity(0.2),
            //   ),
            // ),

          ),
          // Image.asset(
          //   "assets/work/background.jpg",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          //  // color: Colors.grey.withOpacity(0.1),
          // ),


      Scaffold(
        backgroundColor: Colors.transparent,
        //backgroundColor:Colors.white,
        body: Form(key: formKey,
          child: SingleChildScrollView(

            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                //Image.asset('assets/icons/ho.jpg',fit: BoxFit.cover,) ,
                GestureDetector(
                  // onTap: () {
                  //   setState(() {
                  //     login = true;
                  //   });
                  // },
                  child:Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(top: 0),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child:Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 178,),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color:Colors.transparent,
                                      image: DecorationImage(
                                        colorFilter:
                                        ColorFilter.mode(Colors.transparent,
                                            BlendMode.colorBurn),
                                        image: new AssetImage(
                                          'assets/work/output-onlinepngtools1.png',
                                        ),
                                      ),

                                    ),
                                  ),
                                  Container(
                                      child:Text('صنايعي ',
                                        style: TextStyle(
                                          fontSize: 55,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: 'vibes',
                                          //fontStyle: FontStyle.italic,
                                        ),)
                                  ),
                                  Container(
                                    width: 300,
                                    height: 60,
                                    margin: EdgeInsets.only(top:80,),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          side: BorderSide(color: Colors.transparent)
                                      ),
                                      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                                      color:Y2,
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Loginscreen()));
                                      },
                                      child: Text(
                                        "تسجيل الدخول",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          fontFamily: 'Changa',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 60,
                                    margin: EdgeInsets.only(top:10,),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          side: BorderSide(color: Colors.transparent)
                                      ),
                                      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                                      color:Colors.white,
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignWorker()));
                                      },
                                      child: Text(
                                        " تسجيل الدخول كمقدم خدمة",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          fontFamily: 'Changa',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 60,
                                    margin: EdgeInsets.only(top:10,),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          side: BorderSide(color: Colors.transparent)
                                      ),
                                      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                                      color:Colors.white,
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignuserScreen()));
                                      },
                                      child: Text(
                                        "إنشاء حساب جديد",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          fontFamily: 'Changa',
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Stack(
                                  //   children:[
                                  //     Container(
                                  //         margin: EdgeInsets.only(top:60),
                                  //         child:Text(' تطبيق صنايعي هو تطبيق يقدم العديد من الخدمات المنزلية كنجار وكهربائي ... سجل معنا الآن لتتلقى جميع خدمات صنايعي ',
                                  //           style: TextStyle(
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.bold,
                                  //             color:Colors.black87,
                                  //             fontFamily: 'Changa',
                                  //           ),)
                                  //     ),
                                  //     Container(
                                  //       margin: EdgeInsets.only(top:120,right: 145),
                                  //       child:GestureDetector(
                                  //           onTap: (){
                                  //             Navigator.of(context).push(MaterialPageRoute(
                                  //                 builder: (BuildContext context) => SignuserScreen()));
                                  //           },
                                  //           child:Text('سجّل معنا',
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.bold,
                                  //               color: Colors.black,
                                  //               decoration: TextDecoration.underline,
                                  //               fontFamily: 'Changa',),)
                                  //
                                  //       ),),
                                  //     Container(
                                  //       margin: EdgeInsets.only(top:220,right: 0),
                                  //       child: GestureDetector(
                                  //         onTap: (){
                                  //           Navigator.of(context).push(MaterialPageRoute(
                                  //               builder: (BuildContext context) => Loginscreen()));
                                  //         },
                                  //         child:Text('هل لديك حساب ؟ تسجيل الدخول',
                                  //           style: TextStyle(
                                  //             fontSize: 15.3,
                                  //             fontWeight: FontWeight.bold,
                                  //             color:Colors.black87,
                                  //             // decoration: TextDecoration.underline,
                                  //             fontFamily: 'Changa',),)
                                  //
                                  //     ),),
                                  //      Container(
                                  //        margin: EdgeInsets.only(top:250,right: 0),
                                  //        child:LinearPercentIndicator(
                                  //       alignment: MainAxisAlignment.center,
                                  //       width: 240.0,
                                  //       lineHeight: 4.0,
                                  //       animation: true,
                                  //       percent:1.0,
                                  //       animationDuration: 6000,
                                  //       backgroundColor: Colors.grey,
                                  //       progressColor: Colors.yellow,
                                  //     ),),
                                  //   ],),


                                  // Container(
                                  //   margin: EdgeInsets.only(top:45,right: 120),
                                  //   padding: EdgeInsets.only(left: 5,right:5),
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: Color(0xFFF3D657),
                                  //     ),
                                  //   ),
                                  //   child:GestureDetector(
                                  //       onTap: (){
                                  //         Navigator.of(context).push(MaterialPageRoute(
                                  //             builder: (BuildContext context) => SignWorker()));
                                  //       },
                                  //       child:Text('مقدم خدمة سجّل هنا؟',
                                  //         style: TextStyle(
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Color(0xFFF3D657),
                                  //           // decoration: TextDecoration.underline,
                                  //           fontFamily: 'Changa',),)
                                  //
                                  //   ),),
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
              ],

            ),),
        ),),],),);
  }
}
class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color =Colors.transparent;
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
class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top:200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000),Color(0xffffcc66),]
        ),
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}
