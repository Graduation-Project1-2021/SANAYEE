import 'dart:math';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/Inside_the_app/Comment.dart';
import 'package:flutterphone/Inside_the_app/List_worker_group.dart';
import 'package:flutterphone/Inside_the_app/WORKER_PROFILE.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/Inside_the_app/user_order.dart';
import 'package:flutterphone/USER/user_reserve_order.dart';
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
import 'menue_Page.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class favarate extends StatefulWidget {
  final phoneuser;
  final username;
  final namelast;
  final namefirst;
  final image;
  final token;
  favarate({this.username,this.phoneuser,this.namefirst,this.namelast,this.image,this.token});
  _favarate createState() =>  _favarate();
}
class  _favarate extends State<favarate> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool button1=true;
  bool button2=false;
  bool button3=false;
  bool step3=false;

  Future getMyfaverate()async{
    var url='https://'+IP4+'/testlocalhost/faverate.php';
    var ressponse=await http.post(url,body: {
      "phoneuser": widget.phoneuser,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  getChat(){
    databaseMethods.getChatsMe(widget.username).then((val){
      setState(() {
        print(val.toString());
        chatsRoom=val;
      });
    });
  }
  @override
  void initState() {
    super.initState();
     getChat();
  }
  int _selectedIndex = 3;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            // appBar: new AppBar(
            //   backgroundColor: Y2,
            //   leading:GestureDetector(
            //     onTap: (){
            //       Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
            //     },
            //     child:Icon(Icons.arrow_back,color: Colors.white,),
            //   ),
            //   title: new Text('المفضلة',
            //     style: TextStyle(
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: 'Changa',
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
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
                          icon: Icons.favorite_border,
                          text: 'المفضلة',
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
                          }
                          if(index==1){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.username,phoneuser: widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                          }
                          if(index==2){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.username,chatsRoomList: chatsRoom,phone:widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                          }
                          if(index==3){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.username,phoneuser: widget.phoneuser,namelast:widget.namelast,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                          }
                          if(index==4){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MenuePage(namelast:widget.namelast,name:widget.username,phone:widget.phoneuser,image:widget.image,token:widget.token,namefirst:widget.namefirst)));
                          }

                        });
                      }
                  ),
                ),
              ),),
            body: Form(
              // child:SingleChildScrollView(
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // colors: [B,A,G]
                          colors: [Y1,Y4]
                      ),
                    ),),
                 Container(
                    height: 600,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:130),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:FutureBuilder(
                      future: getMyfaverate(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              return f(usertoken:widget.token,userimage:widget.image,usernamelast:widget.namelast,usernamefirst:widget.namefirst,index:index,phoneuser:widget.phoneuser,username:widget.username,phone:snapshot.data[index]['phone'],image:snapshot.data[index]['image'],work:snapshot.data[index]['Work'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],name:snapshot.data[index]['name'],);
                              return Container(child: Text('bggngn'),);
                            },
                          );
                        }
                        return Center(child: Container(height: 0,));
                      },
                    ),
                  ),
                ],),),
          ),],),);
  }
// Future<void> _dialogCall() {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//        // return Directionality(textDirection: ui.TextDirection.rtl,
//         //  child:eaccept_order(image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
//       });
// }
}
class f  extends StatefulWidget {
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final username;
  final phoneuser;
  final index;
  final usernamelast;
  final usernamefirst;
  final userimage;
  final usertoken;
  //
  f({this.username,this.usernamefirst,this.usernamelast,this.usertoken,this.index,this.phoneuser,this.country,this.work,this.image,this.namefirst,this.namelast,this.name,this.phone,this.userimage});

  @override
  _f createState() => _f();
}
class _f extends State<f> {
  var List=[];
  var DateList=[];
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content:
     Text(text,
      style: TextStyle(
      fontFamily: 'Changa',
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),)));
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        GestureDetector(
          onTap: (){
          },
          child:Container(
            width: 350,
            height: 100,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color:Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.only(bottom: 20,),
            padding: EdgeInsets.only(right: 10,top: 10,bottom: 10),
            child:Row(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 10, right: 5),
                  child: CircleAvatar(backgroundImage: NetworkImage(
                      'https://' + IP4 + '/testlocalhost/upload/' + widget.image),
                    radius: 40.0,),),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 10, right: 10),
                        child: Text(widget.namefirst+" "+widget.namelast, style: TextStyle(
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
                        margin: EdgeInsets.only(right: 10),
                        child:  Text(widget.work, style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ),
                    ],
                ),),
               GestureDetector(
                 onTap: ()async{
                   await delete_faverate();
                   _showSnackBar(context, 'تمت الإزالة من قائمة المفضلة لديك');
                   Navigator.push(context, MaterialPageRoute(builder: (context) => favarate(phoneuser:widget.phoneuser,username:widget.username,namelast:widget.usernamelast,image:widget.userimage,token:widget.usertoken,namefirst:widget.usernamefirst),),);
                 },
                 child:Container(
                   child: Icon(Icons.favorite,size: 25,color: Colors.red,),
                 ),
               ),
            ],),
          // Container(
          //   padding: EdgeInsets.all(20),
          //   width: MediaQuery.of(context).size.width*0.2,
          //   child: Text(date, style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.w700,
          //   ), textAlign: TextAlign.right,),
          // ),
        ),),],
    );

  }

  Future delete_faverate() async {
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/delete_faverate.php';
    var ressponse = await http.post(url, body: {
      "phoneuser":widget.phoneuser,
      "phoneworker":widget.phone,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
}




