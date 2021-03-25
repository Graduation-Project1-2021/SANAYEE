import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Chat/chatListUser.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:flutterphone/constants.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class day_order_weak extends StatefulWidget {
  // final name_Me;
  // final country;
  // final namefirst;
  // final namelast;
  // final image;
  // final phone;
  // All_Service({this.name_Me,this.country,this.namefirst,this.namelast,this.image,this.phone});
  _day_order_weak createState() =>  _day_order_weak();
}
class  _day_order_weak extends State<day_order_weak> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00 ","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool step1=true;
  bool step2=true;
  bool step3=false;
  bool step4=false;
  @override
  void initState() {
    super.initState();
    // getChat();
  }
  Color bulbColor = Colors.red;
  int _selectedIndex = 0;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  int _selectedItem = 0;
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 100,
                    decoration: BoxDecoration(
                      // color:ca,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [G,A,B]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE()));
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  Container(
                    child:Column(
                      children: [
                       Container(
                         child: Container(

                         ),
                       ),
                      ],
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 450,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:170),
                    padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      //),
                    ),
                    child:SingleChildScrollView(
                      child:Column(
                        children: [
                          Container(
                            width: 350,
                            height: 150,
                            padding: EdgeInsets.only(right: 10,top:10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(1.0,1.0), // shadow direction: bottom right
                                )
                              ],

                            ),
                            child: Column(
                              children: [
                                Text('رتوشات وأمور بسيطة ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.8,
                                    fontFamily: 'Changa',
                                    fontWeight: FontWeight.bold,),)
                              ],
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 150,
                            margin: EdgeInsets.only(top:30),
                            padding: EdgeInsets.only(right: 10,top:10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(1.0,1.0), // shadow direction: bottom right
                                )
                              ],

                            ),
                            child: Column(
                              children: [
                                Text('ورشات عمل قد تستغرق عدة أيام أو أسابيع كورشات دهان أو ورشات تركيب وتفصيل خزائن',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.8,
                                    fontFamily: 'Changa',
                                    fontWeight: FontWeight.bold,),)
                              ],
                            ),
                          ),
                        ],),),
                  ),],),),
          ),],),);
  }
}