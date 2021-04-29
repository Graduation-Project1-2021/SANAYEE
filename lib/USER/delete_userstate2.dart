import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutterphone/USER/search_user.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
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

class delete_user_statues2 extends StatefulWidget {
  final country;
  final id;
  final namefirst;
  final namelast;
  final image;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final time;
  final datesend;
  final timecancel;
  final timesend;
  final datecancel;
  final work;
  final AVG;
  final who;
  final token;
  final name;
  delete_user_statues2({this.id,this.name,this.token,this.who,this.datecancel,this.timecancel,this.AVG,this.work,this.timesend,this.datesend,this.time,this.date,this.country,this.namefirst,this.namelast,this.image,this.phoneuser,this.phoneworker,this.description});
  _delete_user_statues2 createState() =>  _delete_user_statues2();
}
class  _delete_user_statues2 extends State<delete_user_statues2> {
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
  @override
  void initState() {
    super.initState();
    // getChat();
  }
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
            backgroundColor: Colors.grey[50],
            key: _scaffoldKey,
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
                      Navigator.pop(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  Container(
                    height: 110,
                    width: 400,
                    margin: EdgeInsets.only(top:120,right: 15,left: 15),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),

                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     offset: Offset(0, 1),
                      //     blurRadius: 0.02,
                      //     color: Colors.black,
                      //   ),
                      // ],
                    ),
                    child:Row(
                      children: [
                        Container(
                          // print(_image[index].id+"");
                          width: 90,
                          height: 90,
                          margin: EdgeInsets.only(right: 10,top:0),
                          decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 250,
                              margin: EdgeInsets.only(top:9,right: 6),
                              alignment: Alignment.topRight,
                              child:Row(
                                children: [
                                  Text(widget.namefirst+" "+widget.namelast, style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    fontFamily: 'Changa',
                                  ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 20,
                              margin: EdgeInsets.only(top:5,right: 6),
                              alignment: Alignment.topRight,
                              child: Text(widget.work, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),
                              ),
                            ),
                            Container(
                              width: 250,
                              // color:Colors.green,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top:0,right:10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 120,
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top:7),
                                    child:Row(
                                      children: [
                                        Text(""+widget.country, style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                          fontFamily: 'Changa',
                                        ),
                                        ),
                                        Icon(Icons.location_on,size:20,color:Colors.black87,),
                                      ],
                                    ),

                                  ),
                                  SizedBox(width:60,),
                                  ClipOval(
                                    child: Material(
                                      color: Y, // button color
                                      child: InkWell(
                                        // splashColor: Colors.black87, // inkwell color
                                        child: SizedBox(width: 30, height: 30, child: Icon(Icons.phone,color: Colors.white,size: 20,)),
                                        onTap: () {
                                          String phone=widget.phoneworker.substring(3);
                                          UrlLauncher.launch("tel://"+phone);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width:10,),
                                  ClipOval(
                                    child: Material(
                                      color: Y, // button color
                                      child: InkWell(
                                        // splashColor: Colors.black87, // inkwell color
                                        child: SizedBox(width: 30, height: 30, child: Icon(Icons.mark_chat_unread,color: Colors.white,size: 20,)),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 300,
                    width: 450,
                    margin: EdgeInsets.only(top:250,right: 15),
                    padding:EdgeInsets.only(right:0,left: 0),
                    decoration: BoxDecoration(

                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:Column(
                      children: [
                        GestureDetector(
                          // onTap: (){
                          //   print('fbfgbfbfb');
                          // },
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 350,
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 2),
                                child:Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top:5),
                                            alignment: Alignment.topRight,
                                            child:Icon(Icons.check_circle,size: 25,color: step1?perp1:Colors.grey,),
                                          ),
                                          Container(
                                            transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                            margin: EdgeInsets.only(top:0),
                                            height: 50,
                                            child:VerticalDivider(
                                              color: perp1,
                                              thickness: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          margin: EdgeInsets.only(right: 10,top:6),
                                          child: Text('إرسال الطلب',
                                            style: TextStyle(
                                              fontFamily: 'Changa',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                        ),
                                        // Container(
                                        //   width: 300,
                                        //   margin: EdgeInsets.only(right: 10),
                                        //   child: Text(' تاريخ ' + widget.datesend +' '+ "في الساعة "+ widget.timesend,
                                        //     style: TextStyle(
                                        //       fontFamily: 'Changa',
                                        //       color: Colors.black45,
                                        //       fontSize: 13.0,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          // onTap: (){
                          //   print('fbfgbfbfb');
                          // },
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 350,
                                transform: Matrix4.translationValues(0.0, -13.0, 0.0),
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 2,top:0),
                                child:Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top:5),
                                            alignment: Alignment.topRight,
                                            child:Icon(Icons.check_circle,size: 25,color: step1?perp1:Colors.grey,),
                                          ),
                                          Container(
                                            transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                            margin: EdgeInsets.only(top:0),
                                            height: 50,
                                            child:VerticalDivider(
                                              color:Colors.grey,
                                              thickness: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          margin: EdgeInsets.only(right: 10,top:6),
                                          child: Text('تثبيت الطلب',
                                            style: TextStyle(
                                              fontFamily: 'Changa',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                        ),
                                        // Container(
                                        //   width: 300,
                                        //   margin: EdgeInsets.only(right: 10),
                                        //   child: Text(' تاريخ ' + widget.dateaccept +' '+ "في الساعة "+ widget.timeaccept,
                                        //     style: TextStyle(
                                        //       fontFamily: 'Changa',
                                        //       color: Colors.black45,
                                        //       fontSize: 13.0,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          // onTap: (){
                          //   print('fbfgbfbfb');
                          // },
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 350,
                                alignment: Alignment.topRight,
                                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                                margin: EdgeInsets.only(right: 2),
                                child:Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top:0),
                                            alignment: Alignment.topRight,
                                            child:Icon(Icons.cancel,size: 25,color:Colors.red),
                                          ),
                                          Container(
                                            transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                            margin: EdgeInsets.only(top:0),
                                            height: 50,
                                            child:VerticalDivider(
                                              color: Colors.grey,
                                              thickness: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          margin: EdgeInsets.only(right: 10,),
                                          child: Text('البدء في العمل',
                                            style: TextStyle(
                                              fontFamily: 'Changa',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                        ),
                                        // Container(
                                        //   width: 300,
                                        //   margin: EdgeInsets.only(right: 10),
                                        //   child: Text('تم بعت هذا الطلب إليك في تاريخ ' + widget.datesend +'\n'+ "في الساعة "+ widget.timesend,
                                        //     style: TextStyle(
                                        //       fontFamily: 'Changa',
                                        //       color: Colors.black45,
                                        //       fontSize: 14.0,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          // onTap: (){
                          //   print('fbfgbfbfb');
                          // },
                          child: Row(
                            children: [
                              Container(
                                height: 53,
                                width: 350,
                                alignment: Alignment.topRight,
                                transform: Matrix4.translationValues(0.0, -32.0, 0.0),
                                margin: EdgeInsets.only(right: 2),
                                child:Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top:0),
                                            alignment: Alignment.topRight,
                                            child:Icon(Icons.cancel,size: 25,color:Colors.red,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          margin: EdgeInsets.only(right: 10,),
                                          child: Text('إنتهاء العمل',
                                            style: TextStyle(
                                              fontFamily: 'Changa',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                        ),
                                        // Container(
                                        //   width: 300,
                                        //   margin: EdgeInsets.only(right: 10),
                                        //   child: Text('تم بعت هذا الطلب إليك في تاريخ ' + widget.datesend +'\n'+ "في الساعة "+ widget.timesend,
                                        //     style: TextStyle(
                                        //       fontFamily: 'Changa',
                                        //       color: Colors.black45,
                                        //       fontSize: 14.0,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),
                      ],),),
                  Container(
                    child: Column(
                      children:[
                        Container(
                          width:500,
                          height: 55,
                          margin: EdgeInsets.only(top:742.7,),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search_user(country:widget.country,token_Me:widget.token,work:widget.work,name_Me: widget.name,location: widget.country,namefirst_Me:widget.namefirst,nameLast_Me:widget.namelast,phone_Me: widget.phoneuser,image_Me: widget.image,),),);
                              // DateTime date=DateTime.now();
                              // var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                              // print(widget.phone);
                              // print(date);
                              // // Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:date,phoneworker: widget.phone,),),);
                              // print(widget.phoneuser); print(widget.name_Me); print(widget.phone);
                              // print(widget.token); print(widget.tokenuser);print("=====================================================");
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:date,name_Me:widget.name_Me,token_Me:widget.tokenuser,tokenworker: widget.token,phoneworker: widget.phone,phone: widget.phoneuser,),),);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                side: BorderSide(color: Colors.transparent)
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                            color:Y,
                            child: Text(
                              "حجز مرة أخرى",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                fontFamily: 'Changa',
                              ),
                            ),
                          ),
                        ),
                      ],),
                  ),

                ],),),
          ),],),);
  }
}