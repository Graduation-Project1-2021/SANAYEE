import 'dart:typed_data';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterphone/Chatworker/Conversation.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

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
import 'Worker_conferm_order.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class State_order_accept extends StatefulWidget {
  final namefirstworker;
  final namelastworker;
  final imageworker;
  final tokenworker;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final name;
  final time;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  final id;
  final Am_Pm;
  final ChooseDate;
  final workername;
  final orderimage;
  final lat;
  final lng;
  final latuser;
  final lnguser;
  final city;
  final Information;
  final Experiance;
  final token;
  final work;
  State_order_accept({this.namefirstworker,this.namelastworker,this.imageworker,this.tokenworker,this.work,this.Information,this.Experiance,this.token,this.city,this.latuser,this.lnguser,this.lng,this.lat,this.Am_Pm,this.orderimage,this.workername,this.ChooseDate,this.name,this.id,this.timeaccept,this.timesend,this.dateaccept,this.datesend,this.time,this.date,this.country,this.namefirst,this.namelast,this.image,this.phoneuser,this.phoneworker,this.description});
  _State_order_accept createState() =>  _State_order_accept();
}
class  _State_order_accept extends State<State_order_accept> {
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
  List<Marker> mark = [];
  @override
  void initState() {
    super.initState();
    add();

    // getChat();
  }
  CreatChatRoom (){
    print(widget.workername);
    print(widget.name);
    String chatRoomId= getChatRoomId(widget.workername,widget.name);
    List<String>Users=[widget.name,widget.workername];
    Map<String,dynamic>ChatRoom={
      "users":Users,
      "chatroomid":chatRoomId
    };
    databaseMethods.createChat(chatRoomId, ChatRoom);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Conversation(chatRoomId: chatRoomId,name_Me: widget.workername,name: widget.name,namefirst: widget.namefirst,namelast: widget.namelast,image: widget.image,);
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
  int _selectedIndex = 0;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  bool press=true;
  double h=200;
  @override
  int _selectedItem = 0;
  bool addn=false;
  Future<void> addmark() async {
    final Uint8List markerIcon= await getBytesFromAsset('assets/icons/current.png',100);
    int id = 0;
    Marker m = new Marker(markerId: MarkerId(id.toString()),
      infoWindow: InfoWindow(title:"ME",onTap: (){
      }),
      position: LatLng(double.parse(widget.lat,),
          double.parse(widget.lng)), icon:BitmapDescriptor.fromBytes(markerIcon),
    );
    mark.add(m);
    final Uint8List markerIconuser= await getBytesFromAsset('assets/icons/worker.png',150);
    id = 1;
    Marker m1 = new Marker(markerId: MarkerId(id.toString()),
      infoWindow: InfoWindow(title:widget.namefirst+" "+widget.namelast,onTap: (){
      }),
      position: LatLng(double.parse(widget.latuser,),
          double.parse(widget.lnguser)), icon:BitmapDescriptor.fromBytes(markerIconuser),
    );
    mark.add(m1);
    addn=true;
  }
  Future<void> add() async {

      await addmark();
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  Widget build(BuildContext context) {
    print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW");
    print(widget.lng);
    print(widget.lat);
    print(widget.lnguser);
    print(widget.latuser);
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
                    height: 200,
                    width: 500,
                    margin: EdgeInsets.only(top:0,),
                    child: FutureBuilder(
                      future: add(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (mark.isNotEmpty) {
                         return showgoogle(mark);
                        }
                        else{
                          return Container();
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(widget.workername);
                      print(widget.phoneworker);
                      print(widget.ChooseDate);
                      print('kjjkkjjkkjjkkjjk');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => accept_order(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.namelastworker,image:widget.imageworker,token:widget.tokenworker,namefirst:widget.namefirstworker,name:widget.workername,phone: widget.phoneworker,time:widget.ChooseDate,)));
                    },
                    child:  Container(
                      margin: EdgeInsets.only(top: 60,left: 300,right: 10),
                      child:Icon(Icons.arrow_back,color: Colors.black87,size: 25,),
                    ),
                  ),
                  Container(
                    width: 400,
                    margin: EdgeInsets.only(top:205,right: 15,left: 15),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child:Column(
                      children: [
                        Container(
                          child:Row(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child:Row(
                                  children: [
                                    Text(""+widget.country+" ("+widget.city+") ", style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),
                                    ),
                                    Icon(Icons.location_on,size:20,color:Colors.black87,),
                                  ],
                                ),

                              ),
                              SizedBox(width:159,),
                              Container(
                                width: 50,
                                child: FlatButton(
                                  onPressed: () {
                                    print("chat");
                                    CreatChatRoom();
                                  },
                                  child: new Icon(
                                    Icons.mark_chat_unread,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  shape: new CircleBorder(),
                                  color:Y,
                                ),
                              ),
                              Container(
                                width: 50,
                                //padding: EdgeInsets.symmetric(horizontal: 3),
                                child: FlatButton(
                                  onPressed: () {
                                    String phone=widget.phoneuser.substring(3);
                                    UrlLauncher.launch("tel://"+phone);
                                    // UrlLauncher.launch("tel://0595320479");
                                  },
                                  child: new Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  shape: new CircleBorder(),
                                  color: Y,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 540,
                          child:SingleChildScrollView(
                            child:accept(Experiance:widget.Experiance,Information:widget.Information,work:widget.work,country:widget.country,city:widget.city,latuser:widget.latuser,lnguser:widget.lnguser,lat:widget.lat,lng:widget.lng,Am_Pm:widget.Am_Pm,orderimage:widget.orderimage,workername:widget.workername,ChooseDate:widget.ChooseDate,name:widget.name,id:widget.id,timesend:widget.timesend,timeaccept:widget.timeaccept,dateaccept:widget.dateaccept,datesend:widget.datesend,date:widget.date,time:widget.time,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phoneworker,image: widget.image,),
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children:[
                        Container(
                          width:500,
                          height: 55,
                          margin: EdgeInsets.only(top:742.7,),
                          child: FlatButton(
                            onPressed: ()async{
                              await _dialogCall2();//DateTime date=DateTime.now();
                              // var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                              // print(widget.phone);
                              // print(date);// print(widget.phoneuser); print(widget.name_Me); print(widget.phone);
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
                              "إلغاء الطلب",
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
                ],

              ),),
          ),],),);
  }
  Container showgoogle(List<Marker>mark){
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: 400,
      width: 500,
      child:GoogleMap(
        initialCameraPosition: CameraPosition(target:
        LatLng(((double.parse(widget.lat)+double.parse(widget.latuser))/2),((double.parse(widget.lng)+double.parse(widget.lnguser))/2)),
            zoom:8.5),
        markers: mark.toSet(),
        //scrollGesturesEnabled: true,
        zoomControlsEnabled: false,
        padding: EdgeInsets.only(right: 350.0,top:60),        // zoomGesturesEnabled: true,
        myLocationButtonEnabled: false,
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
      ),
    );
  }
  Future<void> _dialogCall2() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:delete_order(chooseDate:widget.ChooseDate,phoneuser:widget.phoneuser,phoneworker:widget.phoneworker,image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
        });
  }
}


class accept extends StatefulWidget {
  final country;
  final namefirst;
  final namelast;
  final image;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final name;
  final time;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  final id;
  final Am_Pm;
  final ChooseDate;
  final workername;
  final orderimage;
  final lat;
  final lng;
  final latuser;
  final lnguser;
  final city;
  final Information;
  final Experiance;
  final token;
  final work;
  accept({this.work,this.Information,this.Experiance,this.token,this.city,this.latuser,this.lnguser,this.lng,this.lat,this.Am_Pm,this.orderimage,this.workername,this.ChooseDate,this.name,this.id,this.timeaccept,this.timesend,this.dateaccept,this.datesend,this.time,this.date,this.country,this.namefirst,this.namelast,this.image,this.phoneuser,this.phoneworker,this.description});
  _accept createState() =>  _accept();
}
class  _accept extends State<accept> {
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
  List<Marker> mark = [];
  @override
  void initState() {
    super.initState();
    // getChat();
  }
  int _selectedIndex = 0;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  bool press=true;
  double h=200;
  @override
  int _selectedItem = 0;
  bool addn=false;

  Widget build(BuildContext context) {
    print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW");
    print(widget.lng);
    print(widget.lat);
    print(widget.lnguser);
    print(widget.latuser);
    print(Listsearch.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Container(
        height: 530,
              // color: Colors.red,
        child:SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:5,right: 0),
                    child:Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:10,right: 0),
                          child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 20.0,),),
                        Container(
                          height: 30,
                          margin: EdgeInsets.only(top:15,right: 10),
                          child: Text(widget.namefirst + " "+widget.namelast, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0,0, 0.0),
                    margin: EdgeInsets.only(top:0,right: 0),
                    child:  Row(
                      children: [
                        // Container(
                        //   width:90,
                        //   height: 60,
                        //   child:Text('تفاصبل الطلب', style: TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     color: Colors.black54,
                        //     fontFamily: 'Changa',
                        //   ),
                        //   ),
                        // ),
                        Container(
                          width:360,
                          height: 60,
                          color:Colors.white,
                          margin:EdgeInsets.only(top:10,right: 5),
                          child:Text(widget.description, style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:7),
                    child:Row(
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width:50,
                        child:Text('التاريخ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                      Directionality(textDirection: ui.TextDirection.ltr,
                        child:Container(
                          width: 110,
                          alignment: Alignment.topRight,
                          child:Text(widget.date, style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),),),
                      ),
                    ],
                  ),
                  ),
                  Container(
                    width: 370,
                    margin: EdgeInsets.only(top:3),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(child:Row(
                          children: [
                            Container(
                              width:40,
                              child:Text('الوقت', style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                fontFamily: 'Changa',
                              ),
                              ),
                            ),
                            SizedBox(width:15,),
                            Text(widget.time , style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                              fontFamily: 'Changa',
                            ),),
                            Text(" "),
                            Text(widget.Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                              fontFamily: 'Changa',
                            ),),
                          ],
                        ),),
                      ],
                    ),
                  ),
                  image!=null && !press?Container(
                    // print(_image[index].id+"");
                    width: 200,
                    height: 150,
                    transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                    margin: EdgeInsets.only(left: 165,top:20,bottom: 15),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.orderimage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ):Container(),
                  Container(
                    // transform: Matrix4.translationValues(0.0, -25, 0.0),
                    margin: EdgeInsets.only(top: 0,right:10),
                    child:Row(
                      children: [
                        SizedBox(width: 340,),
                        !press?GestureDetector(
                          onTap: (){
                            press=!press;
                            h=200;
                            setState(() {
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 70,),
                            child: Row(
                              children: [
                                // Text('عرض أقل',
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w700,
                                //     color: Colors.black54,
                                //     fontFamily: 'Changa',
                                //   ),),
                                Icon(Icons.keyboard_arrow_up_outlined,size: 20,color: Colors.black54,),
                              ],
                            ),
                          ),
                        ):
                        GestureDetector(
                          onTap: (){
                            press=!press;
                            if(image==null)h=190;
                            else h=370;
                            setState(() {

                            });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                // Text('عرض المزيد',
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w700,
                                //     color: Colors.black54,
                                //     fontFamily: 'Changa',
                                //   ),),
                                Icon(Icons.keyboard_arrow_down,size: 20,color: Colors.black54,),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 450,
                    margin: press?EdgeInsets.only(top:10):EdgeInsets.only(top:30),
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
                                              child:Icon(Icons.check_circle,size: 25,color: step2?perp1:Colors.grey,),
                                            ),
                                            Container(
                                              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                              margin: EdgeInsets.only(top:0),
                                              height: 50,
                                              child:VerticalDivider(
                                                color:perp1,
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
                                              child:Icon(Icons.check_circle,size: 25,color: step3?perp1:Colors.grey,),
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
                                              child:Icon(Icons.check_circle,size: 25,color: step4?Colors.green:Colors.grey,),
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
                      ],
                    ),
                  ),

          ),);
  }
  Container showgoogle(List<Marker>mark){
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: 400,
      width: 500,
      child:GoogleMap(
        initialCameraPosition: CameraPosition(target:
        LatLng(((double.parse(widget.lat)+double.parse(widget.latuser))/2),((double.parse(widget.lng)+double.parse(widget.lnguser))/2)),
            zoom:8.5),
        markers: mark.toSet(),
        //scrollGesturesEnabled: true,
        zoomControlsEnabled: false,
        padding: EdgeInsets.only(right: 350.0,top:60),        // zoomGesturesEnabled: true,
        myLocationButtonEnabled: false,
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
      ),
    );
  }
  Future<void> _dialogCall2() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:delete_order(chooseDate:widget.ChooseDate,phoneuser:widget.phoneuser,phoneworker:widget.phoneworker,image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
        });
  }
}


class delete_order extends StatefulWidget {
  @override
  final id;
  final phone;
  final time;
  final image;
  final country;
  final namefirst;
  final namelast;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final datesend;
  final timesend;
  final timestart;
  final timeend;
  final chooseDate;
  final name;
  delete_order({this.name,this.chooseDate,this.timeend,this.timestart,this.id,this.phone,this.time,this.date,this.phoneworker,this.phoneuser,this.timesend,this.datesend,this.namelast,this.namefirst,this.description,this.image,this.country});
  _delete_order createState() => new _delete_order();

}
class _delete_order extends State<delete_order> {
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('هل أنت متأكد من أنك تريد حذف هذا الطلب ؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                SizedBox(height:50,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await delete_Order();
                        print('ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
                        DateTime date =DateTime.now();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => accept_order(time: widget.chooseDate,phone: widget.phoneworker,name: widget.name,),),);
                        print('=========================================================================');

                       // Navigator.push(context, MaterialPageRoute(builder: (context) => user_reserve_order(phoneuser:widget.phoneuser,username:widget.name,),),);
                        // Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm__order(time: widget.time,phone: widget.phone,)),);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 170),
                          child:Text('حسنا',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 60),
                          child:Text('إلغاء',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Y,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future delete_Order() async {
    print(widget.id);
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/delete_accept_order.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
      "datecancel":formattedDate,
      "timecancel":formattedTime,
      "who":'worker',
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}

