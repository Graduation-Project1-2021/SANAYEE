import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/WORKER_SANAYEE/Worker_conferm_order.dart';
import 'package:flutterphone/WORKER_SANAYEE/GET_IMGS.dart';
import 'package:flutterphone/Worker/setting_worker.dart';
import 'package:flutterphone/Worker/worker_order.dart';
import 'package:flutterphone/screens/login_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutterphone/constants.dart';
import '../constants.dart';
import '../database.dart';
import 'package:flutterphone/Chat/chatListUser.dart';

import 'Profile.dart';
import 'Worker_not_conferm_order.dart';
import 'Worker_notconferm_order.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";

class order_worker extends StatefulWidget {
  final name;
  final phone;
  order_worker({this.name,this.phone});
  _order_worker createState() =>  _order_worker();
}
class  _order_worker extends State<order_worker> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1=[];
  var ListDate1=[];
  final List2=[];
  var ListDate2=[];
  List<dynamic>L;
  File _file;
  bool uploading = false;
  double val = 0;
  File uploadimage;
  var path_image="";
  // File _file;
  List<File> _image = []; //هاي هي
  int counter = 0;
  final picker = ImagePicker();
  var mytoken ;
  Future getdata1()async{
    var url='https://'+IP4+'/testlocalhost/count.php';
    var ressponse=await http.post(url,body: {
      "phone": phone,
    });
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      //L.add(responsepody[i]['count']);
      List1.add(responsepody[i]['id']);
      ListDate1.add(responsepody[i]['date']);
    }
    // print(List1);
    // print(ListDate1);
  }
  Future getdata2()async{
    var url='https://'+IP4+'/testlocalhost/count2.php';
    var ressponse=await http.post(url,body: {
      "phone": phone,
    });
    var responsepody= json.decode(ressponse.body);
    for(int i=0;i<responsepody.length;i++){
      //L.add(responsepody[i]['count']);
      List2.add(responsepody[i]['id']);
      ListDate2.add(responsepody[i]['date']);
    }
    // print(List2);
    // print(ListDate2);
  }
  getChat(){
    print(widget.name);
    databaseMethods.getChatsMe(widget.name).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  void initState() {
    super.initState();
    getdata1();
    getdata2();
    getChat();

  }
  Future getWorker()async{
    var url='https://'+IP4+'/testlocalhost/getworker.php';
    var ressponse=await http.post(url,body: {
      "name": widget.name,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  int _selectedIndex = 2;
  @override
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: TextDirection.rtl,
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
                      icon: Icons.settings,
                      text: 'الإعدادت',
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
                      if(index==1){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(name: widget.name,)));
                      }
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => order_worker(name: widget.name,phone: phone,)));
                      }
                      if(index==3){
                        // DateTime date=DateTime.now();
                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => accept_order(phone: phone,time:date,)));
                      }
                    });
                  }
              ),
            ),
          ),),
        backgroundColor: Colors.white,
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(40.0), // here the desired height
        //     child: AppBar(
        //       backgroundColor: Color(0xFFECCB45),
        //       elevation: 0.0,
        //       //leading: I,
        //     )
        // ),
        body:Stack(
          overflow: Overflow.visible,
          fit: StackFit.loose,
        children: [
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*3/7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.withOpacity(0.2),Colors.blue.withOpacity(0.2)],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60,right: 10),
            child:IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: (){
              Navigator.pop(context);
             // Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
            }),
          ),
          Container(
            margin: EdgeInsets.only(top: 230),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _customCard1(
                  imageUrl: "assets/work/house-reforms.png",
                  item: "ورشاتي الحاية",
                ),
                GestureDetector(
                  onTap: (){
                    DateTime date=DateTime.now();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => accept_order(name:widget.name,phone: widget.phone,time:date,)));
                  },
                child:_customCard2(
                  imageUrl: "assets/work/taqaat.png",
                  item: "الطقات خفيفة",
                ),),
              ],
            ),
          ),
          SizedBox(height: 40,),
          Container(
            margin: EdgeInsets.only(top: 410),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _customCard3(
                  imageUrl: "clean.png",
                  item: "طلبات الورشات",
                ),
               GestureDetector(
                 onTap: (){
                   print(widget.phone);
                   DateTime date=DateTime.now();
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => not_conferm_order(name:widget.name,phone: widget.phone,time:date,)));
                 },
                 child:_customCard3(
                   imageUrl: "clean.png",
                   item: "طلبات الطقات",
                 ),
               ),
              ],
            ),
          ),
        ],
       ),),);
  }}

_customCard1({String imageUrl, String item}){
  return SizedBox(
    height: 168,
    width: 150,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl,width: 70,height: 70,),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child:Text(
                      item,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
_customCard2({String imageUrl, String item}){
  return SizedBox(
    height: 168,
    width: 150,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 0,),
            Image.asset(imageUrl,width: 60,height: 50,),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child:Text(
                      item,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
_customCard3({String imageUrl, String item}){
  return SizedBox(
    height: 168,
    width: 150,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl,width: 70,height: 70,),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child:Text(
                      item,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class ClippingClass extends CustomClipper<Path>{
  @override

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 120);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}