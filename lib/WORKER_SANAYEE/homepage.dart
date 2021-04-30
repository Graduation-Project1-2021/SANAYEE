
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import "dart:io";
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../database.dart';
import 'Profile.dart';
import 'homepage.dart';
import 'menue_Page.dart';
import 'odersperson_day.dart';
import 'orders_workers.dart';
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'package:flutterphone/Chatworker/Conversation.dart';

String IP4="192.168.1.8";
bool showmap=true;
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

// var url = "http://maps.google.com/mapfiles/ms/icons/";
// url + = "blue";
int count =0;
List<dynamic>Worker;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class orderpperson_map extends StatefulWidget {
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final country;
  final Information;
  final Experiance;
  final lat;
  final lng;
  final int countorder;
  orderpperson_map({this.countorder,this.Information,this.Experiance,this.lat,this.lng,this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me});
  // final location;
  //   final work;
  //  final name_Me;
  //MyApp1({this.location,this.work,this.name_Me});
  _mState createState() => _mState();
}

class _mState extends State<orderpperson_map> {

  getChat(){
    print(widget.name_Me);
    databaseMethods.getChatsMe(widget.name_Me).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  Future getWorker() async {
    var url = 'https://' + IP4 + '/testlocalhost/getworker.php';
    var ressponse = await http.post(url, body: {
      "name": widget.name_Me,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  void initState() {
    super.initState();
    getChat();

  }
  today() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/userlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": phone,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }
  int _selectedIndex=0;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  int length=5;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: ui.TextDirection.rtl,
      child:Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar:Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  rippleColor: Colors.grey[300],
                  hoverColor: Colors.grey[100],
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'الرئيسية',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){
                      },
                      icon: Icons.calendar_today,
                      text: 'طلباتي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      onPressed: (){

                      },
                      icon: Icons.mark_chat_unread,
                      text: 'شات',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'حسابي',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GButton(
                      icon: Icons.menu,
                      text: 'القائمة',
                      textStyle:TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                      // if(index==0){
                      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name_Me)));
                      // }

                      if(index==1){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.nameLast_Me,name:widget.name_Me,phone:widget.phone_Me,image:widget.image_Me,token:widget.token_Me,namefirst:widget.namefirst_Me,)));
                      }
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name_Me,chatsRoomList: chatsRoom,Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.nameLast_Me,phone:widget.phone_Me,image:widget.image_Me,token:widget.token_Me,namefirst:widget.namefirst_Me,)));
                      }
                      if(index==3){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(name:widget.name_Me,phone: widget.phone_Me,)));
                      }
                      if(index==4){
                        DateTime date=DateTime.now();
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:widget.Information,Experiance:widget.Experiance,Work:widget.work,namelast:widget.nameLast_Me,name:widget.name_Me,phone:widget.phone_Me,image:widget.image_Me,token:widget.token_Me,namefirst:widget.namefirst_Me,)));
                      }
                    });
                  }
              ),
            ),
          ),),
        backgroundColor: Colors.white,
        body:Column(
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
            Container(height: 650,
              margin: EdgeInsets.only(top: 40,),
              decoration: BoxDecoration(
              ),
              child: FutureBuilder(
                future: today(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                      print("AAAAAAAAAAAAAAAAAAAAAA");
                      print(snapshot.data.length);
                      length=snapshot.data.length;
                      return w(length:length,phone_Me: phone,name_Me:widget.name_Me,);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),),);
  }
}
class w extends StatefulWidget {
  List<dynamic>Location;
  final work;
  final name_Me;
  final namefirst_Me;
  final nameLast_Me;
  final phone_Me;
  final image_Me;
  final token_Me;
  final lat;
  final lng;
  final country;
  final int length;
  w({this.length,this.lat,this.lng,this.country,this.token_Me,this.image_Me,this.namefirst_Me,this.nameLast_Me,this.phone_Me,this.work,this.name_Me,this.Location});
  //w({this.Location,this.work});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<w> {
  PermissionStatus _permissionGranted;
  bool serviceEnabled;
  int i = 0;
  var List_Worker = [];
  var list_ = [];
  var list_distance = [];
  var List_button=[];
  List<Marker> markers = [];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  get url => null;

  @override
  void initState() {
    super.initState();
  }

  Set<Circle> circles;
  bool S = false;
  today() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/userlocation.php';
    // for(int i=0;i<list_.length;i++){
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "phoneworker": widget.phone_Me,
      "date":formattedDate,

    });
    return json.decode(ressponse.body);
  }
  finished_order(String id) async {
    print(id);
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/finishedorder.php';
    var ressponse = await http.post(url, body: {
      //"phone":list_ [i],
      "id":id,
      "datefinished":formattedDate,
      "timefinished":formattedTime,

    });
    return json.decode(ressponse.body);
  }
  delete_order(String id) async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/delete_accept_order.php';
    var ressponse = await http.post(url, body: {
      "id": id,
      "datecancel":formattedDate,
      "timecancel":formattedTime,
      "who":'worker',
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }

  Container order_user(int index,String namefirst,String namelast,String image,String timestart,String timeend,String Am_Pm,String id){
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom:20),
      decoration: BoxDecoration(
        color:Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  // print(_image[index].id+"");
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.only(right: 10,top:0),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  height: 100,
                  margin: EdgeInsets.only(right:0,top:0),
                  child:  Column(
                    children: [
                      SizedBox(height:15,),
                      Container(
                        width: 200,
                        height: 30,
                        //color: Colors.green,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 0,bottom: 0,left: 50,right:10),
                        child: Text(namefirst + " " + namelast,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold,),
                        ),),
                      SizedBox(height:10,),
                      Container(
                        height:40,
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width:10,),
                                    Text("الوقت ", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(timestart +" - " +timeend, style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    Text(" "),
                                    Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                      fontFamily: 'Changa',
                                    ),),
                                    SizedBox(width: 5,),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 55,
                  // margin: EdgeInsets.only(top:10),
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
                    color: Y,
                  ),
                ),

                SizedBox(width:30,),
                GestureDetector(
                  onTap: () async{
                    await finished_order(id);
                    widget.Location.removeAt(index);
                    setState(() {

                    });
                  },
                 child:Container(
                      height: 50,
                      width: 120,
                      child:FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.transparent)
                          ),
                          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                          color:Colors.green,
                          onPressed: (){
                          },
                          child:Row(
                            children: [
                              Text('تم الانتهاء',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: 'Changa',
                                  //fontStyle: FontStyle.italic,
                                ),),
                              SizedBox(width:5,),
                              Icon(Icons.check,color:Colors.white,size:24,),
                            ],
                          )
                      ),
                    ),
                  ),
                SizedBox(width:15,),
              ],
            ),),
        ],),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 690,
      width: 500,
       color: Colors.white,
       child:Column(
         children: [
           widget.length!=0?Container(
             height:650,
             child:Column(
               children: [
                 Container(
                   height:140,
                   margin: EdgeInsets.only(top:0,right:0),
                   padding: EdgeInsets.only(top:70,right: 10,bottom: 20),
                   alignment: Alignment.center,
                   color:Colors.grey[50],
                   // transform: Matrix4.translationValues(0, -120.0, 0),
                   child:Row(
                     children:[
                       SizedBox(width: 140,),
                       Text('طلبات اليوم',
                         style: TextStyle(
                           fontSize: 30,
                           fontWeight: FontWeight.w400,
                           color: Colors.black,
                           fontFamily: 'vibes',
                           //fontStyle: FontStyle.italic,
                         ),),
                       SizedBox(width:100,),
                       Container(
                         width: 50,
                         //padding: EdgeInsets.symmetric(horizontal: 3),
                         child: FlatButton(
                           onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name_Me)));
                             // UrlLauncher.launch("tel://0595320479");
                           },
                           child: new Icon(
                             Icons.location_on,
                             color: Colors.black54,
                             size: 40.0,
                           ),
                           shape: new CircleBorder(),
                           color: Colors.grey[50],
                         ),
                       ),
                     ],
                   ),),

                  Container(height: 450,
                   margin: EdgeInsets.only(top: 0,),
                   decoration: BoxDecoration(
                   ),
                   child: FutureBuilder(
                     future: today(),
                     builder: (BuildContext context, AsyncSnapshot snapshot) {
                       if (snapshot.hasData) {
                         return ListView.builder(
                           itemCount: snapshot.data.length,
                           itemBuilder: (context, index) {
                             print(snapshot.data[index]['id']);
                             return order_user(index,snapshot.data[index]['namefirst'],snapshot.data[index]['namelast'],snapshot.data[index]['image'],snapshot.data[index]['timestart'],snapshot.data[index]['timeend'],snapshot.data[index]['Am_Pm'],snapshot.data[index]['id']);
                           },);
                       }
                       return Center(child: CircularProgressIndicator());
                     },
                   ),
                 ),
               ],
             ),
           ):
           Container(
             margin: EdgeInsets.only(top:300),
             child:Center(
               child:Column(
                 children: [
                   Image.asset('assets/work/dayoff.png',width:150,height:150,),
                   Container(
                     width:400,
                     alignment: Alignment.center,
                     margin: EdgeInsets.only(top:0),
                     child: Text('لا توجد طلبات يوم إجازة لك',
                       style: TextStyle(
                         color: Colors.black87,
                         fontSize: 15.0,
                         fontFamily: 'Changa',
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ],
       ));

    //  child:FutureBuilder(
    //    future: checkLocationServicesInDevice(),
    //      builder: (BuildContext context, AsyncSnapshot <double>snapshot) {
    //        if (snapshot.hasData) {
    //          print("================================================111111");
    //              return Container(child:Text(snapshot.data.toString()),);
    //        }
    //        return Center(child: CircularProgressIndicator());
    //
    //      }
    //
    // ),
  }

  // @override
}
//}

