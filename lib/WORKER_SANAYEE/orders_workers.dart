import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/WORKER_SANAYEE/Worker_conferm_order.dart';
import 'package:flutterphone/WORKER_SANAYEE/GET_IMGS.dart';
import 'package:flutterphone/WORKER_SANAYEE/warshate.dart';
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
import 'package:flutterphone/Chatworker/chatListworker.dart';
import 'odersperson_day.dart';
import 'view.dart';
import 'Profile.dart';
import 'Worker_Slot.dart';
import 'Worker_notconferm_order.dart';
import 'homepage.dart';
import 'longtimework.dart';
import 'menue_Page.dart';

String  name="";
String  phone="";
String  image="";
String  Work="";
String  Experiance="";
String  Information="";
String  token="";
String IP4="192.168.1.8";

class order_worker extends StatefulWidget {
  final  name;
  final  phone;
  final  image;
  final  Work;
  final  Experiance;
  final  Information;
  final  token;
  final namefirst;
  final namelast;
  final lat;
  final lng;
  order_worker({this.lat,this.lng,this.namefirst,this.namelast,this.name, this.phone, this.image, this.Work, this.Experiance, this.Information, this.token});

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
  Future vc()async{
    var url='https://'+IP4+'/testlocalhost/viewOrder.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
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
  int _selectedIndex = 1;
  @override
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  Widget build(BuildContext context) {
    print(widget.name);
    print('order_worker');
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Directionality( textDirection: TextDirection.rtl,
      child:Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar:Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(.1))
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
                      if(index==0){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home_Page(name: widget.name)));
                      }
                      if(index==2){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.name,chatsRoomList: chatsRoom,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                      }
                      if(index==3){
                        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                        print(widget.image);
                        print(widget.name);
                        print(widget.phone);
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PROFILE(name:widget.name,phone:widget.phone,)));
                      }
                      if(index==4){
                        DateTime date=DateTime.now();
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,name:widget.name,phone:widget.phone,image:widget.image,token:widget.token,namefirst:widget.namefirst,)));
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
              height: 380,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.9),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.black87.withOpacity(0.4),
                      BlendMode.dstATop),
                  image: new AssetImage('assets/work/cvw.jpg',),
                ),
            ),
          ),),
          // Container(
          //   margin: EdgeInsets.only(top: 100,),
          //   height: 100,
          //   decoration: BoxDecoration(
          //     color:Colors.transparent,
          //     image: DecorationImage(
          //       colorFilter:
          //       ColorFilter.mode(Colors.transparent,
          //           BlendMode.colorBurn),
          //       image: new AssetImage(
          //         'assets/work/output-onlinepngtools1.png',
          //       ),
          //     ),
          //
          //   ),
          // ),
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 150,),
            child:Center(
                child:Text('صنايعي ',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'vibes',
                    //fontStyle: FontStyle.italic,
                  ),)
            ),),
          Container(
            margin: EdgeInsets.only(top: 300,right: 150),
            child: Row(
              children: [

               GestureDetector(
                  onTap: (){
                    print(widget.phone);
                    DateTime date=DateTime.now();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Worker_SLot(name: widget.name,phone: widget.phone,time:date,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                  },
                  child:SizedBox(
                    height: 90,
                    width: 95,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.calendar_today),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child:Text(
                                      'جدول أعمالي',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
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
                  ),
                ),
              ],

            ),
          ),
          // Container(
          //     alignment: Alignment.center,
          //     transform: Matrix4.translationValues(0, -120.0, 0),
          //     margin: EdgeInsets.only(top: 0,),
          //     child:Text('ورشاتي حجوزاتي طلباتي',
          //       style: TextStyle(
          //         fontSize: 30,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.black,
          //         fontFamily: 'vibes',
          //         //fontStyle: FontStyle.italic,
          //       ),)
          // ),
          Container(
            margin: EdgeInsets.only(top: 405),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    print(widget.phone);
                    DateTime date=DateTime.now();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewWarsha(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,name:widget.name,phone: widget.phone)));
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => viewreservation(phoneuserd:widget.phone,workerphoned:widget.phone,nameofworkd:widget.name,namefirstd:widget.namefirst,namelastd:widget.namelast,)));
                  },
                  child:SizedBox(
                    height: 100,
                    width: 130,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.playlist_add_outlined),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child:Text(
                                      'طلبات الورشات',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
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
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print(widget.phone);
                    DateTime date=DateTime.now();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => not_conferm_order(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,name:widget.name,phone: widget.phone,time:date,)));
                  },
                  child:SizedBox(
                    height: 100,
                    width: 130,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.notifications),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child:Text(
                                      'طلبات الطقات',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
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
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 512),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Warshat(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,name:widget.name,phone: widget.phone)));
                  },
                  child: _customCard1(
                    imageUrl: "assets/work/house-reforms.png",
                    item: "ورشاتي الحاية",
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    DateTime date=DateTime.now();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => accept_order(lat:widget.lat,lng:widget.lng,Information:widget.Information,Experiance:widget.Experiance,Work:widget.Work,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst,name:widget.name,phone: widget.phone,time:date,)));
                  },
                child:_customCard2(
                  imageUrl: "assets/work/taqaat.png",
                  item: "الطقات خفيفة",
                ),),
              ],
            ),
          ),
          SizedBox(height: 40,),
        ],
       ),),);
  }}

_customCard1({String imageUrl, String item}){
  return SizedBox(
    height: 135,
    width: 130,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl,width: 50,height: 50,),
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
                        fontSize: 14.0,
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
    height: 135,
    width: 130,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 0,),
            Image.asset(imageUrl,width: 40,height: 40,),
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
                        fontSize: 14.0,
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
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 90);
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