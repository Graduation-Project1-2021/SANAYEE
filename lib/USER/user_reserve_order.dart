import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterphone/ChatUuser/chatListUser.dart';
import 'package:flutterphone/USER/user_Profile.dart';
import 'package:flutterphone/USER/warshat_delete1_stata.dart';
import 'package:flutterphone/USER/warshat_delete_state.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'delete_userstate2.dart';
import 'warshat_current_state.dart';
import 'warshat_finished_state.dart';
import 'warshat_wait_state.dart';
import 'package:flutterphone/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'Rate_Me.dart';
import 'current_user_states.dart';
import 'daycancel_user_state.dart';
import 'delete_user_state.dart';
import 'favarate.dart';
import 'finish_user_stste.dart';
import 'menue_Page.dart';
import 'not_conferm_user_state.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class user_reserve_order extends StatefulWidget {
  final phoneuser;
  final username;
  final country;
  final namelast;
  final namefirst;
  final token;
  final image;
  user_reserve_order({this.token,this.image,this.namefirst,this.namelast,this.country,this.username,this.phoneuser,});
  _user_reserve_order createState() =>  _user_reserve_order();
}
class  _user_reserve_order extends State<user_reserve_order> {
  // AnimationController _animationController;
  int _page = 0;
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool button1=false;
  bool button2=true;
  bool button3=false;
  bool button4=false;
  bool step3=false;


  Future getwarshate()async{
    var url='https://'+IP4+'/testlocalhost/user_current_warshat.php';
    var ressponse=await http.post(url,body: {
      "phone": widget.phoneuser,
    });
    print("PHONE"+widget.phoneuser);
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getMyorder()async{
    var url='https://'+IP4+'/testlocalhost/user_current_order.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future getallorders()async{
    var url='https://'+IP4+'/testlocalhost/user_current_order_not_conferm.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future get_delete_current()async{
    var url='https://'+IP4+'/testlocalhost/user_current_delete_order.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
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
  int _selectedIndex = 1;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    return Directionality(textDirection: ui.TextDirection.rtl,
      child:Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              elevation: 0.0,
              backgroundColor: Y,
              leading:GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
                },
                child:Icon(Icons.arrow_back,color: Colors.white,),
              ),
              title: new Text('جميع طلباتي',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa',
                  color: Colors.white,
                ),
              ),
            ),
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
                      color: Y,
                      margin: EdgeInsets.only(top: 0),
                     child: SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                      child:Row(
                      children: [
                        // GestureDetector(
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     margin: EdgeInsets.only(left: 10,right: 20),
                        //     height: 60,
                        //     width: 110,
                        //     decoration: BoxDecoration(
                        //       //color: Colors.white,
                        //       // border: Border.all(
                        //       //   color: Colors.white,
                        //       // ),
                        //       border:button1? Border(
                        //         bottom: BorderSide( //
                        //           color: Colors.black,
                        //           width: 3.0,
                        //         ),
                        //       ):Border(),
                        //       // borderRadius: BorderRadius.circular(10),
                        //       color: Colors.transparent,
                        //     ),
                        //     child: Text('ورشاتي',
                        //       style: TextStyle(
                        //         color: button1==true?Colors.black:Colors.white,
                        //         fontSize: 14,
                        //         fontFamily: 'Changa',
                        //         fontWeight: FontWeight.bold,),
                        //     ),
                        //   ),
                        //   onTap: (){
                        //     button1=true;
                        //     button2=false;
                        //     button3=false;
                        //     button4=false;
                        //     setState(() {
                        //
                        //     });
                        //   },
                        // ),
                        GestureDetector(
                          child: Container(

                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            height: 60,
                            width: 110,
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              // border: Border.all(
                              //   color: Colors.white,
                              // ),
                                border:button2? Border(
                                  bottom: BorderSide( //
                                    color: Colors.black,
                                    width: 3.0,
                                  ),
                                ):Border(),
                              // borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Text('ورشاتي',
                              style: TextStyle(
                                color: button2==true?Colors.black:Colors.white,
                                fontSize: 14,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          onTap: (){
                            button1=false;
                            button2=true;
                            button3=false;
                            button4=false;
                            setState(() {

                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(

                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10,right: 15),
                            height: 60,
                            width: 110,
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              // border: Border.all(
                              //   color: Colors.white,
                              // ),
                              border:button3? Border(
                                bottom: BorderSide( //
                                  color: Colors.black,
                                  width: 3.0,
                                ),
                              ):Border(),
                              // borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Text('طقاتي الحالية',
                              style: TextStyle(
                                color: button3==true?Colors.black:Colors.white,
                                fontSize: 14,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          onTap: (){
                           button1=false;
                           button2=false;
                           button3=true;
                           button4=false;
                           setState(() {

                           });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10,right: 20),
                            height: 60,
                            width: 116,
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              // border: Border.all(
                              //   color: Colors.white,
                              // ),
                              border:button4? Border(
                                bottom: BorderSide( //
                                  color: Colors.black,
                                  width: 3.0,
                                ),
                              ):Border(),
                              // borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Text('تم إنهاؤها',
                              style: TextStyle(
                                color: button4==true?Colors.black:Colors.white,
                                fontSize: 14,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          onTap: (){
                            button1=false;
                            button2=false;
                            button3=false;
                            button4=true;
                            setState(() {

                            });

                          },
                        ),

                      ],
                    )
                  ),),
                  button1==true?  Container(
                    height: 600,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:100),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:FutureBuilder(
                      future: getMyorder(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              var Listslot=snapshot.data;
                              bool dayend=false;
                              DateTime now=DateTime.now();
                              DateTime date=DateTime.parse(snapshot.data[index]['dateaccept']);
                              if(date.compareTo(now)<0 && snapshot.data[index]['states']=='notfinished'){
                                print('ooooooooooops date finished');
                                dayend=true;
                              }
                              bool cancelpermition=true;
                              final birthday = DateTime.parse(snapshot.data[index]['dateaccept']);
                              final date2 = DateTime.now();
                              final difference = date2.difference(birthday).inHours;
                              if(difference>=24){
                                cancelpermition=false;
                                print('more than 24 hour');
                              }
                              if(dayend==true || snapshot.data[index]['states']=='finished'){
                                return Dismissible(
                                  background: Container(

                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20,top: 20,bottom: 30,left:20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text('إزالة من قائمتك', style: TextStyle(color: Colors.white,
                                            fontFamily: 'Changa',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          SizedBox(width: 5,),
                                          Icon(Icons.delete, color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                  key: ObjectKey(snapshot.data[index]),
                                  child: Container(
                                    padding: EdgeInsets.only(right: 20,left:20),
                                    child:end_order(workername:snapshot.data[index]['name'],token:snapshot.data[index]['token'],country:widget.country,cancelpermition:cancelpermition,dayend:dayend,Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['states'],id:snapshot.data[index]['id'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],),

                                  ),
                                  onDismissed: (direction) {

                                  },
                                );
                                return end_order(workername:snapshot.data[index]['name'],token:snapshot.data[index]['token'],country:widget.country,cancelpermition:cancelpermition,dayend:dayend,Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['states'],id:snapshot.data[index]['id'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],);
                              }
                              return Container(height:0,);
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ):Container(),
                  button2==true?  Container(
                    height: 600,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:100),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                    ),
                    child:FutureBuilder(
                      future: getwarshate(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                background: Container(

                                ),
                                secondaryBackground: Container(
                                  color: Colors.white,
                                  child: Container(
                                    child:Column(
                                      children: [
                                        Container(
                                          height: 140,
                                          color: Colors.red,
                                          padding: EdgeInsets.only(right:280),
                                          child:  Row(
                                            children: <Widget>[
                                              Text('إزالة من قائمتك', style: TextStyle(color: Colors.white,
                                                fontFamily: 'Changa',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                              SizedBox(width: 5,),
                                              Icon(Icons.delete, color: Colors.white),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                                key: ObjectKey(snapshot.data[index]),
                                child: Container(
                                  margin: EdgeInsets.only(right: 20,left:20,bottom: 20,),
                                  child: warshat(
                                    name:widget.username,
                                    deleteornot:snapshot.data[index]['deleteornot'],
                                    start:snapshot.data[index]['start'],
                                    country:snapshot.data[index]['country'],
                                    accept: snapshot.data[index]['accept'],
                                    type: snapshot.data[index]['type'],
                                    token: snapshot.data[index]['token'],
                                    Rate: snapshot.data[index]['Rate'],
                                    username: widget.username,
                                    ststes: snapshot.data[index]['state'],
                                    id: snapshot.data[index]['id'],
                                    description: snapshot
                                        .data[index]['description'],
                                    phone: snapshot.data[index]['phoneuser'],
                                    phoneworker: snapshot.data[index]['phone'],
                                    work: snapshot.data[index]['Work'],
                                    image: snapshot.data[index]['image'],
                                    namefirst: snapshot
                                        .data[index]['namefirst'],
                                    namelast: snapshot.data[index]['namelast'],
                                    date: snapshot.data[index]['date'],
                                    timestart: snapshot.data[index]['Fromdate'],
                                    timeend: snapshot.data[index]['Todate'],),
                                ),
                                onDismissed: (direction) {

                                },
                              );
                            },);
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ):Container(),
                  button3==true? Container(
                        height: 600,
                        width: 500,
                        // color:  Color(0xFFF3D657),
                        margin: EdgeInsets.only(top:100),
                        //padding:EdgeInsets.only(right:25,left: 25),
                        decoration: BoxDecoration(
                          // color:Color(0xFF1C1C1C),
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(50),
                          //   topRight: Radius.circular(50),
                          // ),
                        ),
                        child:FutureBuilder(
                          future: getallorders(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                itemCount:snapshot.data.length,
                                itemBuilder: (context, index) {
                                  var Listslot=snapshot.data;
                                  bool dayend=false;
                                  DateTime now=DateTime.now();
                                  DateTime date=DateTime.parse(snapshot.data[index]['dateaccept']);
                                  if(date.compareTo(now)<0 && snapshot.data[index]['state']=='notfinished'){
                                    print('ooooooooooops date finished');
                                    dayend=true;
                                  }
                                  bool cancelpermition=true;
                                  final birthday = DateTime.parse(snapshot.data[index]['dateaccept']);
                                  final date2 = DateTime.now();
                                  final difference = date2.difference(birthday).inHours;
                                  if(difference>=24){
                                    cancelpermition=false;
                                    print('more than 24 hour');
                                  }
                                  if(snapshot.data[index]['state']!='finished'&&dayend!=true&&snapshot.data[index]['deleteornot']!='yes') {
                                    return Dismissible(
                                      background: Container(

                                      ),
                                      secondaryBackground: Container(
                                        color: Colors.white,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 140,
                                                color: Colors.red,
                                                padding: EdgeInsets.only(
                                                    right: 280),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text('إزالة من قائمتك',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Changa',
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                        )),
                                                    SizedBox(width: 5,),
                                                    Icon(Icons.delete,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                      key: ObjectKey(snapshot.data[index]),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 20, left: 20, bottom: 20,),
                                        child: delete_order(
                                          start:snapshot.data[index]['start'],
                                          accept:snapshot.data[index]['accept'],
                                          deleteornot:snapshot.data[index]['deleteornot'],
                                          cancelpermition: cancelpermition,
                                          workertoken: snapshot
                                              .data[index]['token'],
                                          token: snapshot.data[index]['token'],
                                          country: snapshot
                                              .data[index]['country'],
                                          who: snapshot
                                              .data[index]['whocancel'],
                                          timecancel: snapshot
                                              .data[index]['timecancel'],
                                          datecancel: snapshot
                                              .data[index]['datecancel'],
                                          username: widget.username,
                                          ststes: snapshot
                                              .data[index]['state'],
                                          name: widget.username,
                                          id: snapshot.data[index]['id'],
                                          timeaccept: snapshot
                                              .data[index]['timeaccept'],
                                          timesend: snapshot
                                              .data[index]['timesend'],
                                          dateaccept: snapshot
                                              .data[index]['dateaccept'],
                                          datesend: snapshot
                                              .data[index]['datesend'],
                                          description: snapshot
                                              .data[index]['description'],
                                          phone: snapshot
                                              .data[index]['phoneuser'],
                                          phoneworker: snapshot
                                              .data[index]['phone'],
                                          work: snapshot.data[index]['Work'],
                                          image: snapshot.data[index]['image'],
                                          namefirst: snapshot
                                              .data[index]['namefirst'],
                                          namelast: snapshot
                                              .data[index]['namelast'],
                                          date: snapshot.data[index]['date'],
                                          timestart: snapshot
                                              .data[index]['timestart'],
                                          timeend: ['timeend'],),

                                      ),
                                      onDismissed: (direction) {

                                      },
                                    );
                                  }
                                  return Container(height:0,);
                                },
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      )
                  :Container(),
                  button4==true?  Container(
                    height: 600,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:100),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:FutureBuilder(
                      future: getallorders(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              var Listslot=snapshot.data;
                              bool dayend=false;
                              DateTime now=DateTime.now();
                              DateTime date=DateTime.parse(snapshot.data[index]['dateaccept']);
                              if(date.compareTo(now)<0 && snapshot.data[index]['state']=='notfinished'){
                                print('ooooooooooops date finished');
                                dayend=true;
                              }
                              bool cancelpermition=true;
                              final birthday = DateTime.parse(snapshot.data[index]['dateaccept']);
                              final date2 = DateTime.now();
                              final difference = date2.difference(birthday).inHours;
                              if(difference>=24){
                                cancelpermition=false;
                                print('more than 24 hour');
                              }
                              if(snapshot.data[index]['state']=='finished'||dayend==true||snapshot.data[index]['deleteornot']=='yes') {
                                return Dismissible(
                                  background: Container(

                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.white,
                                    child: Container(
                                      child:Column(
                                        children: [
                                          Container(
                                            height: 140,
                                            color: Colors.red,
                                            padding: EdgeInsets.only(right:280),
                                            child:  Row(
                                              children: <Widget>[
                                                Text('إزالة من قائمتك', style: TextStyle(color: Colors.white,
                                                  fontFamily: 'Changa',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                                SizedBox(width: 5,),
                                                Icon(Icons.delete, color: Colors.white),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),

                                    ),
                                  ),
                                  key: ObjectKey(snapshot.data[index]),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20,left:20,bottom: 20,),
                                    child:end_order( start:snapshot.data[index]['start'], accept:snapshot.data[index]['accept'], deleteornot:snapshot.data[index]['deleteornot'],workername:snapshot.data[index]['name'],token:snapshot.data[index]['token'],country:snapshot.data[index]['country'],cancelpermition:cancelpermition,dayend:dayend,Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['state'],id:snapshot.data[index]['id'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],),

                                  ),
                                  onDismissed: (direction) {

                                  },
                                );
                                return end_order(workername:snapshot.data[index]['name'],token:snapshot.data[index]['token'],country:widget.country,cancelpermition:cancelpermition,dayend:dayend,Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['states'],id:snapshot.data[index]['id'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],);
                              }
                              return Container(height:0,);
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ):Container(),

                ],),),
          ),],),);
  }
  Widget stackBehindDismiss() {
    return Container(
      height: 50,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(100),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
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

class warshat  extends StatefulWidget {
  final username;
  final  date;
  final  timeend;
  final  timestart;
  final id;
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final phoneworker;
  final description;
  final time;
  final  token;
  final workertoken;
  final index;
  final ststes;
  final accept;
  final Rate;
  final bool dayend;
  final bool cancelpermition;
  final type;
  final start;
  final deleteornot;
  warshat({this.deleteornot,this.start,this.accept,this.type,this.cancelpermition,this.dayend,this.Rate,this.username,this.ststes,this.index,this.token,this.workertoken,this.description,this.id,this.country,this.phoneworker,this.work,this.image,this.namefirst,this.namelast,this.name,this.date, this.timeend, this.timestart,this.phone, this.time});

  @override
  _warshat createState() => _warshat();
}
class _warshat extends State<warshat> {
  var List=[];
  var DateList=[];
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        card(widget.date,widget.namefirst+" "+widget.namelast,widget.timestart,'8:00','am',widget.image,widget.work,widget.type),
      ],
    );

  }
  GestureDetector card(String date, String name,String timestart,String timeend,String Am_Pm,String image,String work,String type )
  {
    return GestureDetector(
      onTap: (){
        if(widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_warshat_statues(country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        if(widget.ststes=='notfinished'&& widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => conferm_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        if(widget.ststes=='finished'&&widget.accept=='yes'&&widget.start=='yes'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => finished_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        if(widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.deleteornot=='yes'&&widget.start=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => delete_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
        if(widget.ststes=='notfinished'&&widget.accept=='no'&&widget.deleteornot=='yes'&&widget.start=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => delete1_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
      },
      child:Container(
        width: 380,
        height: 140,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color:Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(right: 20,top: 15,bottom: 20),
        child:Column(
          children: [
            Row(
              children: [
                Container(
                  child:Column(
                    children: [
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top:8),
                        alignment: Alignment.topRight,
                        child:Row(
                          children: [
                            Text(name, style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontFamily: 'Changa',
                            ),
                            ),
                            Text("  ("+work+")   ", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                              fontFamily: 'Changa',
                            ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200,
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
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top:7),
                        alignment: Alignment.topRight,
                        child:Row(
                          children: [
                            Text(widget.type, style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                              fontFamily: 'Changa',
                            ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='no'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.25,
                          center: new Text("25%"),
                          progressColor: Y,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 35),
                        child: Text('  انتظار الموافقة', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.25,
                          center: new Text("25%"),
                          progressColor: Colors.red,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('تم إلغاؤه   ', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='no'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.5,
                          center: new Text("50%"),
                          progressColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('موافق عليه', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.5,
                          center: new Text("50%"),
                          progressColor: Colors.red,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text(' تم إلغاؤه    ', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.75,
                          center: new Text("75%"),
                          progressColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('بدأ العمل فيه', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='finished'&&widget.accept=='yes'&&widget.start=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 1,
                          center: new Text("100%"),
                          progressColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child:Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                print(widget.username);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Rate(phoneuser: widget.phone,phoneworker: widget.phoneworker,id: widget.id,username: widget.username,),),);
                              },
                              child:Container(
                                width: 105,
                                alignment: Alignment.topLeft,
                                child:Text('تقييم ', style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  fontFamily: 'Changa',
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ):Container(),
              ],
            ),

            SizedBox(height:5,),
            Row(
              children: [
              ],
            ),
            Container(
              width: 350,
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(child:Row(
                    children: [
                      SizedBox(width: 5,),
                      widget.ststes=='complete' || widget.dayend==true?
                      Container(
                          width: 80,
                          margin: EdgeInsets.only(right: 35),
                          alignment: Alignment.topLeft,
                          child:widget.Rate=='yes'?Container(
                            child:Row(
                              children: [
                                Text(' التقييم', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  fontFamily: 'Changa',
                                ),),
                                Icon(Icons.check,color: Colors.black54,),
                              ],
                            ),
                          ):  GestureDetector(
                            onTap: (){
                              print(widget.username);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Rate(phoneuser: widget.phone,phoneworker: widget.phoneworker,id: widget.id,username: widget.username,),),);
                            },
                            child:Container(
                              width: 80,
                              margin: EdgeInsets.only(right: 25),
                              child:Text('تقييم', style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),),
                            ),
                          )
                      ):Container(),
                    ],
                  ),),
                ],
              ),
            ),
            // Divider(
            //   color: Colors.black54,
            //   thickness: 1.0,
            // ),
          ],
        ),
      ),
      // Container(
      //   padding: EdgeInsets.all(20),
      //   width: MediaQuery.of(context).size.width*0.2,
      //   child: Text(date, style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w700,
      //   ), textAlign: TextAlign.right,),
      // ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد حذف هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //h(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future<void> _showMyAccept() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد قبول هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //sh(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future delete (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/deleteorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    String massage = json.decode(response.body);
    print(massage);
    setState(() {

    });
  }
  Future accept (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/acceptorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    // String massage = json.decode(response.body);
    // print(massage);
  }

}




class delete_order  extends StatefulWidget {
  final username;
  final date;
  final timeend;
  final timestart;
  final Am_Pm;
  final AVG;
  final id;
  final name;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final phoneworker;
  final description;
  final time;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  final datecancel;
  final timecancel;
  final  token;
  final workertoken;
  final ststes;
  final Rate;
  final bool dayend;
  final bool cancelpermition;
  final who;
  final start;
  final deleteornot;
  final accept;
  //
  delete_order({this.start,this.accept,this.deleteornot,this.who,this.cancelpermition,this.dayend,this.Rate,this.username,this.ststes,this.datecancel,this.timecancel,this.AVG,this.token,this.workertoken,this.timeaccept,this.dateaccept,this.datesend,this.timesend,this.description,this.id,this.country,this.phoneworker,this.work,this.image,this.namefirst,this.namelast,this.name,this.date, this.timeend, this.timestart, this.Am_Pm,this.phone, this.time});

  @override
  _delete_order createState() => _delete_order();
}
class _delete_order extends State<delete_order> {
  var List=[];
  var DateList=[];
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        Container(
          child: card(widget.date,widget.namefirst+" "+widget.namelast,widget.timestart,'8:00','am',widget.image,widget.work),

        ),
      ],
    );
  }
  GestureDetector card(String date, String name,String timestart,String timeend,String Am_Pm,String image,String work)
  {
    return GestureDetector(
      onTap: (){
        if(widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_user_statues(country:widget.country,name_Me:widget.name,id:widget.id,AVG:widget.AVG,work:widget.work,timesend:widget.timesend,datesend:widget.datesend,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        if(widget.ststes=='notfinished'&& widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => current_user_statues(country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        if(widget.ststes=='finished'&&widget.accept=='yes'&&widget.start=='yes'){
         // Navigator.push(context, MaterialPageRoute(builder: (context) => finished_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        if(widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.deleteornot=='yes'&&widget.start=='no'){
         // Navigator.push(context, MaterialPageRoute(builder: (context) => delete_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
        if(widget.ststes=='notfinished'&&widget.accept=='no'&&widget.deleteornot=='yes'&&widget.start=='no'){
         // Navigator.push(context, MaterialPageRoute(builder: (context) => delete1_warshat_statues(from:widget.timestart,to:widget.timeend,type:widget.type,country:widget.country,name_Me:widget.name,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
      },
      child:Container(
        width: 380,
        height: 140,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        // margin: EdgeInsets.only(bottom: 20,),
        padding: EdgeInsets.only(right: 20,top: 15,bottom: 10),
        child:Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 220,
                      height: 30,
                      alignment: Alignment.topRight,
                      child:Row(
                        children: [
                          Text(name, style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Changa',
                          ),
                          ),
                          Text("  ("+work+")   ", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: Alignment.topRight,
                      height: 30,
                      child:  Row(
                        children: [
                          Container(
                            width:100,
                            child:Text('التاريخ', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: 'Changa',
                            ),
                            ),
                          ),
                          Container(
                            width:100,
                            child:Text(' الوقت', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: 'Changa',
                            ),
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
                    ),
                    Container(
                      width: 220,
                      child:  Row(
                        children: [
                          Directionality(textDirection: ui.TextDirection.ltr,
                            child:Container(
                              width: 100,
                              alignment: Alignment.topRight,
                              child:Text(date, style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),),),
                          ),
                          Container(child:Row(
                            children: [
                              Text(timestart +"-" +timeend, style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),),
                              Text(" "),
                              Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
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
                  ],
                ),
                widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='no'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 90,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.25,
                          center: new Text("25%"),
                          progressColor: Y,
                        ),
                      ),
                      SizedBox(height: 25,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('انتظار الموافقة', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 90,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.25,
                          center: new Text("25%"),
                          progressColor: Colors.red,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('تم إلغاؤه   ', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='no'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 90,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.5,
                          center: new Text("50%"),
                          progressColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('موافق عليه', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 90,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.5,
                          center: new Text("50%"),
                          progressColor: Colors.red,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text(' تم إلغاؤه    ', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 90,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 0.75,
                          center: new Text("75%"),
                          progressColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child: Text('بدأ العمل فيه', style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),),
                      ),
                    ],
                  ),
                ):Container(),
                widget.ststes=='finished'&&widget.accept=='yes'&&widget.start=='yes'?
                Container(
                  margin: EdgeInsets.only(top: 10,),
                  child:Column(
                    children: [
                      Container(
                        width: 90,
                        alignment: Alignment.topLeft,
                        child:CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 4.0,
                          percent: 1,
                          center: new Text("100%"),
                          progressColor: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 100,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0,right: 20),
                        child:Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                print(widget.username);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Rate(phoneuser: widget.phone,phoneworker: widget.phoneworker,id: widget.id,username: widget.username,),),);
                              },
                              child:Container(
                                width: 100,
                                alignment: Alignment.topLeft,
                                child:Text('تقييم       ', style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  fontFamily: 'Changa',
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ):Container(),
              ],
            ),

           // SizedBox(height:5,),
            // Divider(
            //   color: Colors.black54,
            //   thickness: 1.0,
            // ),
          ],
        ),),
      // Container(
      //   padding: EdgeInsets.all(20),
      //   width: MediaQuery.of(context).size.width*0.2,
      //   child: Text(date, style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w700,
      //   ), textAlign: TextAlign.right,),
      // ),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد حذف هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //h(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future<void> _showMyAccept() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد قبول هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //sh(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future delete (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/deleteorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    String massage = json.decode(response.body);
    print(massage);
    setState(() {

    });
  }
  Future accept (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/acceptorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    // String massage = json.decode(response.body);
    // print(massage);
  }

}


class end_order  extends StatefulWidget {
  final workername;
  final date;
  final timeend;
  final timestart;
  final Am_Pm;
  final AVG;
  final id;
  final username;
  final phone;
  final namefirst;
  final namelast;
  final image;
  final work;
  final country;
  final phoneworker;
  final description;
  final time;
  final datesend;
  final dateaccept;
  final timesend;
  final timeaccept;
  final datecancel;
  final timecancel;
  final  token;
  final workertoken;
  final ststes;
  final Rate;
  final bool dayend;
  final bool cancelpermition;
  final start;
  final deleteornot;
  final accept;
  //
  end_order({this.start,this.deleteornot,this.accept,this.workername,this.cancelpermition,this.dayend,this.Rate,this.ststes,this.datecancel,this.timecancel,this.AVG,this.token,this.workertoken,this.timeaccept,this.dateaccept,this.datesend,this.timesend,this.description,this.id,this.country,this.phoneworker,this.work,this.image,this.namefirst,this.namelast,this.username,this.date, this.timeend, this.timestart, this.Am_Pm,this.phone, this.time});

  @override
  _end_order createState() => _end_order();
}
class _end_order extends State<end_order> {
  var List=[];
  var DateList=[];
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        card(widget.date,widget.namefirst+" "+widget.namelast,widget.timestart,'8:00','am',widget.image,widget.work),
      ],
    );
  }
  GestureDetector card(String date, String name,String timestart,String timeend,String Am_Pm,String image,String work)
  {
    return GestureDetector(
      onTap: (){
        if(widget.ststes=='finished'&&widget.accept=='yes'&&widget.start=='yes'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => finished_user_statues(country:widget.country,name_Me:widget.username,id:widget.id,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }

        else if(widget.ststes=='notfinished'&&widget.accept=='no'&&widget.deleteornot=='yes'&&widget.start=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => delete_user_statues(name:widget.username,id:widget.id,country:widget.country,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
        else if(widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.deleteornot=='yes'&&widget.start=='no'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => delete_user_statues2(name:widget.username,id:widget.id,country:widget.country,work:widget.work,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
      },

      child:Container(
        width: 380,
        height: 140,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        // margin: EdgeInsets.only(bottom: 20,),
        padding: EdgeInsets.only(right: 20,top: 5,bottom: 10),
        child:SingleChildScrollView(
          child:Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 220,
                    height: 30,
                    alignment: Alignment.topRight,
                    child:Row(
                      children: [
                        Text(name, style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Changa',
                        ),
                        ),
                        Text("  ("+work+")   ", style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontFamily: 'Changa',
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    alignment: Alignment.topRight,
                    height: 30,
                    child:  Row(
                      children: [
                        Container(
                          width:100,
                          child:Text('التاريخ', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ),
                        Container(
                          width:100,
                          child:Text(' الوقت', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                  ),
                  Container(
                    width: 220,
                    child:  Row(
                      children: [
                        Directionality(textDirection: ui.TextDirection.ltr,
                          child:Container(
                            width: 100,
                            alignment: Alignment.topRight,
                            child:Text(date, style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                              fontFamily: 'Changa',
                            ),),),
                        ),
                        Container(child:Row(
                          children: [
                            Text(timestart +"-" +timeend, style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                              fontFamily: 'Changa',
                            ),),
                            Text(" "),
                            Text(Am_Pm=="am"?"صباحا":"مساء", style: TextStyle(
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
                ],
              ),
              widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='no'?
              Container(
                margin: EdgeInsets.only(top: 10,),
                child:Column(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.25,
                        center: new Text("25%"),
                        progressColor: Y,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0,right: 20),
                      child: Text('انتظار الموافقة', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ),
                  ],
                ),
              ):Container(),
              widget.ststes=='notfinished'&& widget.accept=='no'&&widget.start=='no'&&widget.deleteornot=='yes'?
              Container(
                margin: EdgeInsets.only(top: 10,),
                child:Column(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.25,
                        center: new Text("25%"),
                        progressColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0,right: 20),
                      child: Text('تم إلغاؤه   ', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ),
                  ],
                ),
              ):Container(),
              widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='no'?
              Container(
                margin: EdgeInsets.only(top: 10,),
                child:Column(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.5,
                        center: new Text("50%"),
                        progressColor: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0,right: 20),
                      child: Text('موافق عليه', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ),
                  ],
                ),
              ):Container(),
              widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='no'&&widget.deleteornot=='yes'?
              Container(
                margin: EdgeInsets.only(top: 10,),
                child:Column(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.5,
                        center: new Text("50%"),
                        progressColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0,right: 20),
                      child: Text(' تم إلغاؤه    ', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ),
                  ],
                ),
              ):Container(),
              widget.ststes=='notfinished'&&widget.accept=='yes'&&widget.start=='yes'?
              Container(
                margin: EdgeInsets.only(top: 10,),
                child:Column(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.75,
                        center: new Text("75%"),
                        progressColor: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0,right: 20),
                      child: Text('بدأ العمل فيه', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),
                    ),
                  ],
                ),
              ):Container(),
              widget.ststes=='finished'&&widget.accept=='yes'&&widget.start=='yes'?
              Container(
                margin: EdgeInsets.only(top: 10,),
                child:Column(
                  children: [
                    Container(
                      width: 90,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 1,
                        center: new Text("100%"),
                        progressColor: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 100,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0,right: 20),
                      child:Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              print(widget.username);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Rate(phoneuser: widget.phone,phoneworker: widget.phoneworker,id: widget.id,username: widget.username,),),);
                            },
                            child:Container(
                              width: 100,
                              alignment: Alignment.topLeft,
                              child:Text('تقييم       ', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'Changa',
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ):Container(),
            ],
          ),),
        ),
      // Container(
      //   padding: EdgeInsets.all(20),
      //   width: MediaQuery.of(context).size.width*0.2,
      //   child: Text(date, style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w700,
      //   ), textAlign: TextAlign.right,),
      // ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد حذف هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //h(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future<void> _showMyAccept() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(right: 50,left:10,top: 30),
          titlePadding: EdgeInsets.only(right: 50,left:50,top: 30),
          content: Text('هل تريد قبول هذا الطلب ',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontFamily: 'Changa',
            ),),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('نعم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  //sh(context,MaterialPageRoute(builder: (BuildContext context) =>work_order(phone: widget.phone,List1: List,ListDate:DateList,)));
                },
              ),),
            Container(
              margin: EdgeInsets.only(left: 10,bottom: 20,top: 30),
              child:FlatButton(
                child: Text('لا',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'Changa',
                  ),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }
  Future delete (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/deleteorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    String massage = json.decode(response.body);
    print(massage);
    setState(() {

    });
  }
  Future accept (final id)async{
    var url = 'https://'+IP4+'/testlocalhost/acceptorder.php';
    var response = await http.post(url, body: {
      "id":id,
    });
    // String massage = json.decode(response.body);
    // print(massage);
  }

}
