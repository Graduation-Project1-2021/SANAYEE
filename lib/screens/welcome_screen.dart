import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
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
    super.initState();
  }
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Form(key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[



                GestureDetector(
                 child: Column(
                  children:[
                    Container(
                      color: Colors.orangeAccent,
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //       begin: Alignment.topLeft,
                      //       end: Alignment.bottomRight,
                      //       stops: [0.5, 1],
                      //       colors: [Color(0xff5f2c82), Color(0xff49a09d)]
                      //   ),
                      // ),
                    height: 800,
                    child:Column(
                      children:[

                        ClipPath(
                          clipper: WaveClipperOne(),
                          child: Container(
                            height: 120,
                            color:Color(0x80A55FF3),
                            //child: Center(child: Text("WaveClipperOne()")),
                          ),
                        ),
                       // ClipPath(clipper: Clipper4(), child: Container(margin: EdgeInsets.only(top:200),height: 300, color:PURPEL,),),
                        Container(
                          margin: EdgeInsets.only(top: 60,),
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
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Changa',
                                fontStyle: FontStyle.italic,
                              ),)
                        ),
                        ClipPath(
                          clipper: WaveClipperOne(reverse: true),
                          child: Container(
                            height: 399,
                            color: Color(0xAD8131D8),
                            margin: EdgeInsets.only(bottom: 5),
                            child:  Center(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  child:Column(
                                    children: [

                                      Stack(
                                        children:[
                                          Container(
                                              margin: EdgeInsets.only(top:60),
                                              child:Text(' تطبيق صنايعي هو تطبيق يقدم العديد من الخدمات المنزلية كنجار وكهربائي ... سجل معنا الآن لتتلقى جميع خدمات صنايعي ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:Colors.white,
                                                  fontFamily: 'Changa',
                                                ),)
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:120,right: 145),
                                            child:GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (BuildContext context) => SignuserScreen()));
                                                },
                                                child:Text('سجّل معنا',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    decoration: TextDecoration.underline,
                                                    fontFamily: 'Changa',),)

                                            ),),
                                          Container(
                                            margin: EdgeInsets.only(top:220,right: 0),
                                            child: GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (BuildContext context) => Loginscreen()));
                                                },
                                                child:Text('هل لديك حساب ؟ تسجيل الدخول',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    // decoration: TextDecoration.underline,
                                                    fontFamily: 'Changa',),)

                                            ),),
                                        ],),


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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //child: Center(child: Text("WaveClipperOne(reverse: true)")),
                          ),
                        ),
                  ],),),
                  ],),),

              ],

            ),),
        ),),);
  }
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


class Clipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height-100);
    path.quadraticBezierTo(size.width/4, size.height/2, size.width/2, size.height-100);
    path.quadraticBezierTo(size.width-size.width/4, size.height -50, size.width, size.height-100);
    path.lineTo(size.width,size.height-100);
    path.lineTo(size.width,0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
class Clipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height-200);
    path.quadraticBezierTo(size.width/3, size.height/2, size.width/2, size.height-100);
    path.quadraticBezierTo(size.width-size.width/3, size.height -10, size.width, size.height-50);
    path.lineTo(size.width,size.height-100);
    path.lineTo(size.width,0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
class Clipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-50);
    path.quadraticBezierTo(size.width/4, size.height/2, size.width/2, size.height-70);
    path.quadraticBezierTo(size.width-size.width/4, size.height, size.width, size.height-200);
    path.lineTo(size.width,size.height-100);
    path.lineTo(size.width,0);

    //path.lineTo(size.width,size.height-100);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}

class Clipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0,size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width, size.height*0.9, size.width/4, size.height*0.9);
    path.quadraticBezierTo(size.width/4,size.height*0.9,0, size.height*0.7);


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}