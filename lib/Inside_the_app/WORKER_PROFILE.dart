import 'dart:ffi';
import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/Conversation.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/Worker/GET_IMGS.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../constants.dart';
import '../database.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";


class user_worker extends StatefulWidget {
  final  name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;


  user_worker({this.name_Me,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _user_worker createState() =>  _user_worker();
}
class  _user_worker extends State<user_worker> {
  // AnimationController _animationController;
  void initState() {
    super.initState();
    getRate();
  }
  double Rate;
  String Rate_S;
  double f=2.2.floorToDouble();
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  Future getRate() async {
    var url = 'https://'+IP4+'/testlocalhost/show_Rate.php';
    var ressponse = await http.post(url, body: {
      "phoneworker": widget.phone,
    });
    return json.decode(ressponse.body);
  }
  @override
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    getRate();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality(textDirection: TextDirection.rtl,
        child:Scaffold(
          backgroundColor:D,
          key: _scaffoldKey,
          // appBar: AppBar(
          //   automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
          //   elevation: 0,
          //   backgroundColor:L_ORANGE,
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back,color: Colors.white,),
          //     onPressed: (){
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          // backgroundColor: Colors.lightBlueAccent,
          body: Form(
            child: Container(
              child:Stack(
              children: [
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   height: 400,
                //   decoration: BoxDecoration(
                //      color:D,
                //     // gradient: LinearGradient(
                //     //     begin: Alignment.topCenter,
                //     //     end: Alignment.bottomCenter,
                //     //     colors: [E,D]),
                //   ),
                // ),
              Container(
                height: 798,
                color: D,
                child:FutureBuilder(
                  future: getRate(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);
                           bool AVG1=double.parse(snapshot.data[index]['AVG1'])>=4?true:false;
                           bool AVG2=double.parse(snapshot.data[index]['AVG2'])>=4?true:false;
                           bool AVG3=double.parse(snapshot.data[index]['AVG3'])>=4?true:false;
                           bool AVG4=double.parse(snapshot.data[index]['AVG4'])>=4?true:false;
                           bool AVG5=double.parse(snapshot.data[index]['AVG5'])>=4?true:false;
                           bool AVG6=double.parse(snapshot.data[index]['AVG6'])>=4?true:false;
                          return worker(AVG1:AVG1,AVG2:AVG2,AVG3:AVG3,AVG4:AVG4,AVG5:AVG5,AVG6:AVG6,Rate:Rate,phone:widget.phone,name: widget.name,namefirst: widget.namefirst,namelast: widget.namelast,image: widget.image,token: widget.token,Information: widget.Information,Experiance: widget.Experiance,name_Me: widget.name_Me,);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],),),),),
    );

}}
class worker extends StatefulWidget {
  final  name_Me;
  final  name;
  final  namefirst;
  final  namelast;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final Rate;
  final bool AVG1;
  final bool AVG2;
  final bool AVG3;
  final bool AVG4;
  final bool AVG5;
  final bool AVG6;

  worker({this.AVG1,this.AVG2,this.AVG3,this.AVG4,this.AVG5,this.AVG6,this.Rate,this.name_Me,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
  _worker createState() =>  _worker();
}
class  _worker extends State<worker> {
  // AnimationController _animationController;
  void initState() {
    super.initState();
    var boolien = [widget.AVG1,widget.AVG2,widget.AVG3,widget.AVG4,widget.AVG5,widget.AVG6];
  }
  var elements = [
    'جودة',
    'سرعة وإتقان',
    'احترام',
    'سعر جيد',
    'التزام بالوقت',
  ];


  double Rate;
  String Rate_S;
  double f=2.2.floorToDouble();
  Future getImages() async {
    var url = 'https://'+IP4+'/testlocalhost/Show_EXP.php';
    var ressponse = await http.post(url, body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    // var responsebody = json.decode(ressponse.body);
    // print(responsebody);
    return json.decode(ressponse.body);
  }
  DatabaseMethods databaseMethods=new DatabaseMethods();
  CreatChatRoom (){
    print(widget.name_Me);
    print(widget.name);
    String chatRoomId=getChatRoomId(widget.name,widget.name_Me);
    List<String>Users=[widget.name_Me,widget.name];
    Map<String,dynamic>ChatRoom={
      "users":Users,
      "chatroomid":chatRoomId
    };
    databaseMethods.createChat(chatRoomId, ChatRoom);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Conversation(chatRoomId: chatRoomId,name_Me: widget.name_Me,name: widget.name,image: widget.image,namefirst: widget.namefirst,namelast: widget.namefirst,);
    },
    ),
    );

  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  int _page = 0;
  int index=0;
  bool image=false;
  bool info=true;
  bool comment=false;
  bool post=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Stack(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(top:10),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  // Container(
                  //   height: 350,
                  //   width: 500,
                  //   color: L_ORANGE,
                  //   //Smargin: EdgeInsets.only(left:0,top:10,right: 340),
                  // ),
                  // Container(
                  //   height: 20,
                  //   width: 40,
                  //   margin: EdgeInsets.only(left:0,top:10,right: 340),
                  //   child: IconButton(
                  //     onPressed: (){
                  //       CreatChatRoom();
                  //     },
                  //     icon:Icon(Icons.mark_chat_unread,color: Colors.white,),
                  //   ),
                  // ),
                  Container(
                    //alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top:30,),
                    //transform: Matrix4.translationValues(0, 5.0, 0),
                    child:Center(
                      child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 35.0,),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:100,),
                    child:Center(
                      child: Text(widget.namefirst+ " "+widget.namelast,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,),),
                    ),),
                  Center(
                    child:Container(
                      width: 60,
                      margin: EdgeInsets.only(top:127,),
                    child:Row(
                      children: [
                        Icon(Icons.star,color: Colors.yellow,size: 27.0,),
                        Text(widget.Rate.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                      ],
                    ),),
                  ),
                  Center(
                    child:Container(
                      margin: EdgeInsets.only(top:130),
                      child:Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 40,
                                    margin: EdgeInsets.only(right: 80, top: 30),
                                    child: IconButton(
                                      icon: Icon(Icons.person,
                                      color:info?Colors.white:Colors.black.withOpacity(0.5),),
                                    ),
                                  ),
                                  // Container(
                                  //   height: 20,
                                  //   width: 25,
                                  //   margin: EdgeInsets.only(right: 50, top: 10),
                                  //   child: Text('حول',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 13.3,
                                  //       fontFamily: 'Changa',
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                //post = true;
                                //image=false;
                              });
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => PROFILE(name: widget.name,profile:1,)),);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 40,
                                    margin: EdgeInsets.only(right: 30, top: 30),
                                    child: IconButton(
                                      icon: Icon(Icons.my_library_books_sharp,
                                        color:post?Colors.white:Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   height: 20,
                                  //   width: 60,
                                  //   margin: EdgeInsets.only(right: 50, top: 10),
                                  //   child: Text('منشورات',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 13.3,
                                  //       fontFamily: 'Changa',
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                //image = true;
                                //post = false;
                              });
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => PROFILE(name: widget.name,profile:1,)),);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 40,
                                    margin: EdgeInsets.only(right: 30, top: 30),
                                    child: IconButton(
                                      icon: Icon(Icons.image,
                                        color:image?Colors.white:Colors.black.withOpacity(0.5),),
                                    ),
                                  ),
                                  // Container(
                                  //   height: 20,
                                  //   width: 25,
                                  //   margin: EdgeInsets.only(right: 50, top: 10),
                                  //   child: Text('صور',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 13.3,
                                  //       fontFamily: 'Changa',
                                  //       fontWeight: FontWeight.bold,
                                  //     ),),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 40,
                                    margin: EdgeInsets.only(right: 30, top: 30),
                                    child: IconButton(
                                      icon: Icon(Icons.comment,
                                          color:comment?Colors.white:Colors.black.withOpacity(0.5),),
                                    ),
                                  ),
                                  // Container(
                                  //   height: 20,
                                  //   width: 50,
                                  //   margin: EdgeInsets.only(right: 50, top: 10),
                                  //   child: Text('تعليقات',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 13.3,
                                  //       fontFamily: 'Changa',
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 510,
                    margin: EdgeInsets.only(top: 240),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Center(
                    child:Container(
                      height: 60,
                      width: 300,
                      margin: EdgeInsets.only(top: 210),
                      padding: EdgeInsets.only(top: 5,left: 0),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        // border: Border.all(
                        //   color: Colors.white,
                        // ),
                        borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [G,B]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(1.0,1.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Row (
                        children: [
                          SizedBox(width: 35,),
                          GestureDetector(
                            child:Column(
                              children: [
                                Text('منشورات',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.8,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),
                                Text('123',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),

                              ],
                            ),
                          ),
                          SizedBox(width: 30,),
                          GestureDetector(
                            child:Column(
                              children: [
                                Text('تعليقات',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.8,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),
                                Text('15',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),

                              ],
                            ),
                          ),
                          SizedBox(width: 40,),
                          GestureDetector(
                            child:Column(
                              children: [
                                Text('عملاء',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.8,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),
                                Text('123',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),),
                 // SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.only(top: 300,),
                    height: 448,
                    width: 700,
                    child:Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child:Wrap(children:[
                            _MyButton(name:'جودة',IS: widget.AVG1,),
                            _MyButton(name:'سرعة وإتقان',IS: widget.AVG2,),
                            _MyButton(name:'احترام',IS: widget.AVG3,),
                            _MyButton(name:'سعر جيد',IS: widget.AVG4,),
                            _MyButton(name:'التزام بالوقت',IS: widget.AVG5,),
                          ]),
                        ),
                        Center(
                          child:Container(
                            width: 500,
                            height: 200,
                            color: Colors.white,
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 40,),
                            padding: EdgeInsets.only(top: 20,right: 30,left:30),

                            child:Column(
                              children: [
                                Text('معلومات                                                       ',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),
                                Text(widget.Information + ', ' + widget.Experiance +'.',style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,),),
                                SizedBox(height: 20,),
                                // Text('خبرة                                                               ',style: TextStyle(
                                //   color: Colors.black,
                                //   fontSize: 17,
                                //   fontFamily: 'Changa',
                                //   fontWeight: FontWeight.bold,),),
                                // Text(widget.Experiance,style: TextStyle(
                                //   color: Colors.black.withOpacity(0.7),
                                //   fontSize: 15.8,
                                //   fontFamily: 'Changa',
                                //   fontWeight: FontWeight.bold,),),
                              ],
                            ),
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: 2,right: 20),
                          child:Row(
                            children: [
                              Container(
                                width: 55,
                                //padding: EdgeInsets.symmetric(horizontal: 3),
                                child: FlatButton(
                                  onPressed: () {
                                    UrlLauncher.launch("tel://0595320479");
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
                                    CreatChatRoom();
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
                              // Container(
                              //   width: 50,
                              //
                              //   child: FlatButton(
                              //     onPressed: () {
                              //
                              //     },
                              //     child: new Icon(
                              //       Icons.arrow_forward,
                              //       color: Colors.white,
                              //       size: 23.0,
                              //     ),
                              //     shape: new CircleBorder(),
                              //     color: Colors.black12,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                       // Container(height: 200,color: Colors.white,)
                      ],

                    ),

                    // child: Row(
                    //   children: [
                        // widget.AVG1?Container(
                        //   margin: EdgeInsets.only(right: 50),
                        //   padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
                        //   width: 60,
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        //   child:Text('جودة',
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16,
                        //       fontFamily: 'Changa',
                        //       fontWeight: FontWeight.bold,),
                        //   ),
                        // ):Container(),
                        // widget.AVG2?Container(
                        //   margin: EdgeInsets.only(right: 10),
                        //   padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
                        //   width: 120,
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        //   child:Text('سرعة و إتقان',
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16,
                        //       fontFamily: 'Changa',
                        //       fontWeight: FontWeight.bold,),
                        //   ),
                        // ):Container(),
                        // widget.AVG3?Container(
                        //   margin: EdgeInsets.only(right: 10),
                        //   padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
                        //   width: 60,
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        //   child:Text('احترام',
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16,
                        //       fontFamily: 'Changa',
                        //       fontWeight: FontWeight.bold,),
                        //   ),
                        // ):Container(),
                        // widget.AVG4?Container(
                        //   margin: EdgeInsets.only(right: 10),
                        //   padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
                        //   width: 100,
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        //   child:Text('سعر جيد',
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16,
                        //       fontFamily: 'Changa',
                        //       fontWeight: FontWeight.bold,),
                        //   ),
                    //     // ):Container(),
                    //   ],
                    // ),
                    ),
                ],



          //         Container(
          //           height: 400,
          //           margin: EdgeInsets.only(top: 140),
          //           color: Colors.white,
          //           child:FutureBuilder(
          //             future: getImages(),
          //          builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         if(snapshot.hasData){
          //            return ListView.builder(
          //             itemCount: 1,
          //             itemBuilder: (context, index) {
          //               int num =snapshot.data.length-4;
          //
          //                 if(snapshot.data.length==0){
          //                   return myAlbum0();
          //                 }
          //                 if(snapshot.data.length==1){
          //                   return myAlbum1('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images']);
          //                 }
          //                 if(snapshot.data.length==2){
          //                   return myAlbum2('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images']);
          //                 }
          //                 if(snapshot.data.length==3){
          //                   return myAlbum3('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images']);
          //                 }
          //                 return myAlbum('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images'],num.toString()+"+");
          //
          //                 return Container();
          //             }
          //         );
          //       }
          //       return Center(child: CircularProgressIndicator());
          //     },
          //   ),
          // ),
    );
  }
  myAlbum(String asset1, String asset2, String asset3, String asset4, String more){
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      // padding:EdgeInsets.fromLTRB(5, 0, 5, 0),
      height:290,
      width:370,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: Colors.grey, width: 1.2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:5,right: 30,),
            child:Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10,bottom: 10,top: 10),
                  // margin:  EdgeInsets.only(left:15,right: 15),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset2, height: 110,
                      width: 159,
                      fit: BoxFit.cover,),
                  ),),
                Container(
                  margin: EdgeInsets.all(10),
                  // margin:  EdgeInsets.only(left:10,),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset1, height: 110,
                      width:159,
                      fit: BoxFit.cover,),
                  ),),
              ],
            ),),
          Container(
            child:Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10,bottom: 10),
                    child:Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            asset4, height: 110,
                            width: 110,
                            fit: BoxFit.cover,),
                        ),
                        Positioned(
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Center(
                              child: Text(more, style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),),),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      asset4, height: 110,
                      width:209,
                      fit: BoxFit.cover,),
                  ),),
              ],),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(left: 230),
            child:Text("الصور",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),),
          ),
        ],),);
  }

  myAlbum0(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:250,
      width:400,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10,bottom: 10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/icons/signup.jpg', height: 110,
                              width: 110,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("انقر لإضافة صور", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }
  myAlbum1(String asset){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
      width:400,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 190,bottom: 10,top:10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset, height: 110,
                              width: 150,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }
  myAlbum2(String asset1,String asset2){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:130,
      width:400,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10,bottom: 10,top:10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset1, height: 110,
                              width: 110,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width:209,
                        fit: BoxFit.cover,),
                    ),),
                ],),
            ),
          ],),
      ),
      // Container(
      //  child:Text("ألبومي "),
      // ),
    );
  }
  myAlbum3(String asset1, String asset2, String asset3){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
      height:250,
      width:400,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 0),
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        shadowColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top:5,right: 30,),
              child:Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10,bottom: 10,top: 10),
                    // margin:  EdgeInsets.only(left:15,right: 15),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset2, height: 110,
                        width: 159,
                        fit: BoxFit.cover,),
                    ),),
                  Container(
                    margin: EdgeInsets.all(10),
                    // margin:  EdgeInsets.only(left:10,),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        asset1, height: 110,
                        width:159,
                        fit: BoxFit.cover,),
                    ),),
                ],
              ),),
            Container(
              child:Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Get_Images(phone:widget.phone,name:widget.name)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 130,bottom: 10),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              asset3, height: 110,
                              width: 209,
                              fit: BoxFit.cover,),
                          ),
                          Positioned(
                            child: Container(
                              height: 110,
                              width: 209,
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("+0", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),),),
                ],),
            ),
            // Container(
            //  child:Text("ألبومي "),
            // ),
          ],),),);
  }

}
class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
class _MyButton extends StatelessWidget {
  _MyButton({Key key, this.name,this.IS}) : super(key: key);
  final String name;
  final bool IS;
  @override
  Widget build(BuildContext context) {
    return IS?Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal:10,vertical:5),
      decoration: BoxDecoration(
        //color: Colors.yellow,
        border: Border.all(
          color: Colors.yellow,
          width: 1.2,
        ),
      ),
      child: Text(name,style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 16,
        fontFamily: 'Changa',
        fontWeight: FontWeight.bold,),),
    ):Text('');
  }
}
