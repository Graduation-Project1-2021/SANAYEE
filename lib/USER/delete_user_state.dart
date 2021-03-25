import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Chat/chatListUser.dart';
import 'package:flutterphone/Inside_the_app/Comment.dart';
import 'package:flutterphone/Inside_the_app/List_worker_group.dart';
import 'package:flutterphone/Inside_the_app/WORKER_PROFILE.dart';
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

class delete_user_statues extends StatefulWidget {
  final country;
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
  delete_user_statues({this.datecancel,this.timecancel,this.AVG,this.work,this.timesend,this.datesend,this.time,this.date,this.country,this.namefirst,this.namelast,this.image,this.phoneuser,this.phoneworker,this.description});
  _delete_user_statues createState() =>  _delete_user_statues();
}
class  _delete_user_statues extends State<delete_user_statues> {
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
                      Navigator.pop(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  Container(
                    height: 130,
                    width: 400,
                    margin: EdgeInsets.only(top:120,right: 15,left: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
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
                          width: 100,
                          height: 100,
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
                              width: 200,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top:15,right:15),
                              child: Text(widget.namefirst + " "+widget.namelast, style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'Changa',
                              ),
                              ),
                            ),
                            Container(
                              width: 200,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top:0,right:15),
                              child: Text(widget.work, style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),
                              ),
                            ),
                            Container(
                              width: 200,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top:0,right:0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 55,
                                    //padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: FlatButton(
                                      onPressed: () {
                                        // UrlLauncher.launch("tel://0595320479");
                                      },
                                      child: new Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 23.0,
                                      ),
                                      shape: new CircleBorder(),
                                      color: D,
                                    ),
                                  ),
                                  Container(
                                    width: 55,
                                    child: FlatButton(
                                      onPressed: () {
                                        //CreatChatRoom();
                                      },
                                      child: new Icon(
                                        Icons.mark_chat_unread,
                                        color: Colors.white,
                                        size: 23.0,
                                      ),
                                      shape: new CircleBorder(),
                                      color: D,
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
                    height: 600,
                    width: 450,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:300),
                    padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:SingleChildScrollView(
                      child:Column(
                        children: [
                          GestureDetector(
                            // onTap: (){
                            //   print('fbfgbfbfb');
                            // },
                            child: Row(
                              children: [
                                Container(
                                  height: 110,
                                  width: 350,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child:Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top:5),
                                              alignment: Alignment.topRight,
                                              child:Icon(Icons.check_circle,size: 30,color: step1?Colors.green:Colors.grey,),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top:10),
                                              child:FDottedLine(
                                                color: Colors.green,
                                                height: 60.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('إرسال الطلب',
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('تم بعت الطلب إليك في تاريخ ' + widget.datesend +'\n'+ "في الساعة "+ widget.timesend,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black45,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
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
                                  height: 110,
                                  width: 350,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child:Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top:5),
                                              alignment: Alignment.topRight,
                                              child:Icon(Icons.cancel,size: 30,color: step2?Colors.red:Colors.grey,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('إلغاء الطلب',
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('لقد تم إلغاء هذا الطلب في تاريخ ' + widget.datecancel +'\n'+ "في الساعة "+ widget.timecancel,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black45,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ],),),
                  ),
                  Container(
                    child: Column(
                      children:[
                        Container(
                          width:500,
                          height: 55,
                          margin: EdgeInsets.only(top:742.7,),
                          child: FlatButton(
                            onPressed: (){
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
                            color:A,
                            child: Text(
                              "حجز مرة أخرى",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21.0,
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