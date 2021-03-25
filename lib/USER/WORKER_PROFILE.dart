import 'dart:ffi';
import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/Chat/Conversation.dart';
import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/USER/user_slot.dart';
import 'package:flutterphone/Worker/GET_IMGS.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import '../constants.dart';
import '../database.dart';
import 'Worker_Slot.dart';

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
  final tokenuser;
  final phoneuser;
  user_worker({this.tokenuser,this.phoneuser,this.name_Me,this.name,this.namelast,this.namefirst, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});
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
    return  Directionality(textDirection: ui.TextDirection.rtl,
        child:Stack(
         children:[
           Container(
             //transform: Matrix4.translationValues(0.0, -70.0, 0.0),
             child:Image(image:NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image,),),
           ),
           // Image(image:NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image,),),
    Scaffold(
          backgroundColor:Colors.transparent,
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
              color: Colors.transparent,
              child:Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:50,left: 310),
                        child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                          Navigator.pop(context);
                         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50,),
                        child:IconButton(icon:Icon(Icons.favorite_border,color: Colors.white,), onPressed: (){
                          print("bbbbbbbbbb");
                          Fluttertoast.showToast(msg: "لقد تمت إضافة العامل إللى قائمة المضلة لديك ",fontSize: 16,backgroundColor: Colors.red);
                        }),
                      ),
                    ],
                  ),
                ),
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
              Stack(
              children:[
                Container(
                  height: 70,
                  color:Colors.white,
                  margin: EdgeInsets.only(top:620.6,),
                  child: Row(
                    children:[
                      Container(
                        width:250,
                        height: 55,
                        margin: EdgeInsets.only(left: 8,right: 15),
                        child: FlatButton(
                          onPressed: (){
                            DateTime date=DateTime.now();
                            var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                            print(widget.phone);
                            print(date);
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:date,phoneworker: widget.phone,),),);
                            print(widget.phoneuser); print(widget.name_Me); print(widget.phone);
                             print(widget.token); print(widget.tokenuser);print("=====================================================");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => My_SLot(date:date,name_Me:widget.name_Me,token_Me:widget.tokenuser,tokenworker: widget.token,phoneworker: widget.phone,phone: widget.phoneuser,),),);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.transparent)
                          ),
                          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                          color:Colors.blue,
                          child: Text(
                            "حجز الآن",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                              fontFamily: 'Changa',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          UrlLauncher.launch("tel://0595320479");
                        },
                        child:Container(
                          width: 55,
                          height: 55,
                          margin: EdgeInsets.only(left:10,),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(1.0,1.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child:Icon(Icons.phone,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          //CreatChatRoom();
                        },
                        child:Container(
                          width: 55,
                          height: 55,
                          margin: EdgeInsets.only(left:10,),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(1.0,1.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child:Icon(Icons.mark_chat_unread,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],),
                ),

                SingleChildScrollView(
                child: Container(
                  height: 532,
                  margin: EdgeInsets.only(top:90),
                  color: Colors.transparent,
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
                          return worker(AVG1:AVG1,AVG2:AVG2,AVG3:AVG3,AVG4:AVG4,AVG5:AVG5,AVG6:AVG6,Rate:Rate,phone:widget.phone,name: widget.name,namefirst: widget.namefirst,namelast: widget.namelast,image: widget.image,token: widget.token,Information: widget.Information,Experiance: widget.Experiance,name_Me: widget.name_Me,Work: widget.Work,);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),),
            ],),],),),),),
   ], ), );

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
    return  Container(
           height: 800,
           color:Colors.white,
          child:Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                 // SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(top: 10,),
                    color:Colors.white,
                    height: 350,
                    width: 700,
                    child:Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right:20,),
                          width: 360,
                          alignment: Alignment.topRight,
                          child:Text(widget.namefirst+ " "+widget.namelast,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Changa',
                              fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          margin: EdgeInsets.only(right:20,),
                          width: 360,
                          alignment: Alignment.topRight,
                          child:Text(widget.Work,style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 370,
                          margin: EdgeInsets.only(right:20,),
                          child:Text(widget.Information + ', ' + widget.Experiance +'.',style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),),
                        ),
                        Center(
                          child:Container(
                            height: 60,
                            width: 380,
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.only(top: 5,left: 0),
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              // border: Border.all(
                              //   color: Colors.white,
                              // ),
                            ),
                            child: Row (
                              children: [
                                SizedBox(width: 20,),
                                GestureDetector(
                                  child:Column(
                                    children: [
                                      Text('منشورات',style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),
                                      Text('123',style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 50,),
                                GestureDetector(
                                  child:Column(
                                    children: [
                                      Text('تعليقات',style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),
                                      Text('15',style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 50,),
                                GestureDetector(
                                  child:Column(
                                    children: [
                                      Text('عملاء',style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),
                                      Text('123',style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 50,),
                                GestureDetector(
                                  child:Column(
                                    children: [
                                      Text('الريت',style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontFamily: 'Changa',
                                        fontWeight: FontWeight.bold,),),
                                      Container(
                                        //margin: EdgeInsets.only(top:320,left: 290),
                                        child:Row(
                                          children: [
                                            Text(widget.Rate.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily: 'Changa',
                                                fontWeight: FontWeight.bold,),),
                                            Icon(Icons.star,color: Colors.yellow,size: 25.0,),
                                          ],
                                        ),),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),),
                        Container(
                          width: 350,
                         margin: EdgeInsets.only(top:15),
                         child: Divider(
                           thickness: 1.0,
                           color: Colors.black26.withOpacity(0.1),
                         ),
                        ),
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
                       // Container(height: 200,color: Colors.white,)
                      ],
                    ),
                    ),
                  Container(
                    height: 400,
                    margin: EdgeInsets.only(top: 20),
                    color: Colors.white,
                    child:FutureBuilder(
                      future: getImages(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                int num =snapshot.data.length-4;

                                if(snapshot.data.length==0){
                                  return myAlbum0();
                                }
                                if(snapshot.data.length==1){
                                  return myAlbum1('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images']);
                                }
                                if(snapshot.data.length==2){
                                  return myAlbum2('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images']);
                                }
                                if(snapshot.data.length>=3){
                                  return worker_Images('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images']);
                                }
                                // return myAlbum('https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+1]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+2]['images'],'https://'+IP4+'/testlocalhost/upload/'+snapshot.data[index+3]['images'],num.toString()+"+");

                                return Container();
                              }
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
          ),);
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

  worker_Images(String Image1,String Image2,String Image3){
    return Container(
      child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [

            Container(
              margin: EdgeInsets.only(left: 10,right: 30),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  Image1, height: 120,
                  width: 160,
                  fit: BoxFit.cover,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  Image2, height: 120,
                  width: 160,
                  fit: BoxFit.cover,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30,right: 10),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      Image2, height: 120,
                      width: 160,
                      fit: BoxFit.cover,),
                  ),
                  Positioned(
                    child: Container(
                      height: 120,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Center(
                        child: Text("عرض كل الصور", style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              // child:ClipRRect(
              //   borderRadius: BorderRadius.circular(5.0),
              //   child: Image.network(
              //     Image3, height: 120,
              //     width: 160,
              //     fit: BoxFit.cover,),
              // ),
            ),
          ],
        ),
      ),);
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
        // border: Border.all(
        //   color: Colors.yellow,
        //   width: 1.2,
        // ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1.0,1.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Text(name,style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 16,
        fontFamily: 'Changa',
        fontWeight: FontWeight.bold,),),
    ):Text('');
  }
}
