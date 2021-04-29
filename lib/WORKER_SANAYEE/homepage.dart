import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/WORKER_SANAYEE/Map.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../constants.dart';
import '../database.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'odersperson_day.dart';
String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String namefirst="";
String namelast="";
String lat="";
String lng="";

String IP4="192.168.1.8";

class Home_Page extends StatefulWidget {
  final name;

  Home_Page({this.name});

  _Home_Page createState() =>  _Home_Page();
}
class  _Home_Page extends State<Home_Page> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  List<dynamic>L;
  int Length=0;
  File _file;
  bool uploading = false;
  double val = 0;
  File uploadimage;
  var path_image = "";

  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  final picker = ImagePicker();
  var mytoken;

  getChat() {
    print(widget.name);
    databaseMethods.getChatsMe(widget.name).then((val) {
      setState(() {
        print(val.toString());
        chatsRoom = val;
      });
    });
  }

  void initState() {
    super.initState();
    getChat();
  }

  Future getWorker() async {
    var url = 'https://' + IP4 + '/testlocalhost/getworker.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  today() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/userlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker":phone,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }

  int _selectedIndex = 0;
  @override
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatsRoom;

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        // bottomNavigationBar:Container(
        //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
        //     BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        //   ]),
        //   child: SafeArea(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        //       child: GNav(
        //           rippleColor: Colors.grey[300],
        //           hoverColor: Colors.grey[100],
        //           gap: 8,
        //           activeColor: Colors.black,
        //           iconSize: 24,
        //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        //           duration: Duration(milliseconds: 400),
        //           tabBackgroundColor: Colors.grey[100],
        //           tabs: [
        //             GButton(
        //               icon: Icons.home,
        //               text: 'الرئيسية',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               onPressed: (){
        //               },
        //               icon: Icons.calendar_today,
        //               text: 'طلباتي',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               onPressed: (){
        //
        //               },
        //               icon: Icons.mark_chat_unread,
        //               text: 'شات',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               icon: Icons.person,
        //               text: 'حسابي',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             GButton(
        //               icon: Icons.menu,
        //               text: 'القائمة',
        //               textStyle:TextStyle(
        //                 fontFamily: 'Changa',
        //                 color: Colors.black,
        //                 fontSize: 14.5,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ],
        //           selectedIndex: _selectedIndex,
        //           onTabChange: (index) {
        //             setState(() {
        //               _selectedIndex = index;
        //               if(index==1){
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
        //               }
        //               if(index==2){
        //               }
        //               if(index==4){
        //                 DateTime date=DateTime.now();
        //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:widget.Information,Experiance:widget.Experiance,Work:Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
        //               }
        //             });
        //           }
        //       ),
        //     ),
        //   ),),
        backgroundColor: Colors.white,
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(100.0), // here the desired height
        //     child: AppBar(
        //       automaticallyImplyLeading:false,
        //       backgroundColor: Color(0xFFECCB45),
        //       elevation: 0.0,
        //       //leading: I,
        //     )
        // ),
        body: Stack(
          children: [

            Container(
              height: 0,
              // color:  Color(0xFFF3D657),
              margin: EdgeInsets.only(top:0),
              decoration: BoxDecoration(
              ),
              child:FutureBuilder(
                future: getWorker(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        name=snapshot.data[index]['name'];
                        phone=snapshot.data[index]['phone'];
                        return Container(height: 0.0,);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              height: 150,
              color: Colors.grey[50],
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => orderpperson_map(lat:lat,lng:lng,countorder:Length,name_Me: widget.name,phone_Me:phone,Information:Information,Experiance:Experiance,token_Me:token,namefirst_Me:namefirst,nameLast_Me: namelast,image_Me:image,)));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 5),
                    child: Text('طلبات اليوم',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 120,
                    margin: EdgeInsets.only(top: 40,right: 170),
                    decoration: BoxDecoration(
                    ),
                    child: FutureBuilder(
                      future: today(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Container(
                              color: Colors.grey[50],
                              child:Row(
                                children: [
                                  // Text('لا توجد طلبات اليوم',
                                  //   style: TextStyle(
                                  //     color: Colors.black87,
                                  //     fontSize: 13.0,
                                  //     fontFamily: 'Changa',
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Image.asset('assets/work/dayoff.png',width:120,height:120,)
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                Length=snapshot.data.length;
                                String text='';
                                if(Length==1){text='طلب';}
                                if(Length==2){text='طلب';}
                                if(Length>=3){text='طلبات';}
                                return Container(
                                  margin: EdgeInsets.only(right: 50),
                                  transform: Matrix4.translationValues(0.0, -28.0, 0.0),
                                  child: Row(
                                    children: [
                                      Text(Length.toString()+'  '+text,
                                        style: TextStyle(
                                          color:Y,
                                          fontSize: 16.0,
                                          fontFamily: 'Changa',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                return ORDER();
                              }
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 700,
              margin: EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
              ),
              child: FutureBuilder(
                future: getWorker(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print('bvvvvvvvvvvvvvvvvvvvvvvvvvvv');
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          name = snapshot.data[index]['name'];
                          namefirst = snapshot.data[index]['namefirst'];
                          namelast = snapshot.data[index]['namelast'];
                          phone = snapshot.data[index]['phone'];
                          image = snapshot.data[index]['image'];
                          Work = snapshot.data[index]['Work'];
                          Information = snapshot.data[index]['Information'];
                          Experiance = snapshot.data[index]['Experiance'];
                          token = snapshot.data[index]['token'];
                          lat=snapshot.data[index]['lat'];
                          lng=snapshot.data[index]['lng'];


                          return order_map(phone_Me: snapshot
                              .data[index]['phone'],
                            name_Me: snapshot.data[index]['name'],
                            namefirst_Me: snapshot.data[index]['namefirst'],
                            nameLast_Me: snapshot.data[index]['namelast'],
                            token_Me: snapshot.data[index]['token']
                            ,
                            work: snapshot.data[index]['Work'],
                            image_Me: snapshot.data[index]['image'],
                            lat: snapshot.data[index]['lat'],
                            lng: snapshot.data[index]['lng'],);
                        }
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],),),);
  }
}
Container ORDER(){
  return Container(
    height: 20,
    color: Colors.red,
  );
}
