import 'dart:math';
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
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'Rate_Me.dart';
import 'current_user_states.dart';
import 'delete_user_state.dart';
import 'favarate.dart';
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
  user_reserve_order({this.username,this.phoneuser,});
  _user_reserve_order createState() =>  _user_reserve_order();
}
class  _user_reserve_order extends State<user_reserve_order> {
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


  Future getMyorder()async{
    var url='https://'+IP4+'/testlocalhost/user_current_order.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future get_not_conferm()async{
    var url='https://'+IP4+'/testlocalhost/user_current_order_not_conferm.php';
    var ressponse=await http.post(url,body: {
      "username": widget.username,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
  }
  Future get_delete()async{
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
  @override
  void initState() {
    super.initState();
    // getChat();
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
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;

                          if(index==0){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.username,)));
                          }
                          if(index==2){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => favarate(username: widget.username,phoneuser:widget.phoneuser,)));
                          }
                          if(index==3){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => user_reserve_order(username: widget.username,)));
                          }
                          if(index==4){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Chat(name_Me:widget.username,chatsRoomList: chatsRoom,user: true,phone:phone,)));
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
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 150,
                    decoration: BoxDecoration(
                      color:Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child:IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
                      Navigator.pop(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => U_PROFILE(name_Me: widget.name_Me,)));
                    }),
                  ),
                  Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 110),
                      child:Row(
                      children: [
                        GestureDetector(
                          child: Container(

                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10,right: 20),
                            height: 60,
                            width: 110,
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              // border: Border.all(
                              //   color: Colors.white,
                              // ),
                                border:button1? Border(
                                  bottom: BorderSide( //
                                    color: Colors.blue,
                                    width: 3.0,
                                  ),
                                ):Border(),
                              // borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Text('حالية',
                              style: TextStyle(
                                color: button1==true?Colors.blue:Colors.black,
                                fontSize: 15,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          onTap: (){
                            button1=true;
                            button2=false;
                            button3=false;
                            setState(() {

                            });
                          },
                        ),
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
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                              ):Border(),
                              // borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Text('غير مثبتة',
                              style: TextStyle(
                                color: button2==true?Colors.blue:Colors.black,
                                fontSize: 15,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          onTap: (){
                           button1=false;
                           button2=true;
                           button3=false;
                           setState(() {

                           });
                          },
                        ),
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
                              border:button3? Border(
                                bottom: BorderSide( //
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                              ):Border(),
                              // borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Text('تم إلغاؤها',
                              style: TextStyle(
                                color: button3==true?Colors.blue:Colors.black,
                                fontSize: 15,
                                fontFamily: 'Changa',
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          onTap: (){
                            button1=false;
                            button2=false;
                            button3=true;
                            setState(() {

                            });

                          },
                        ),

                      ],
                    )
                  ),
                  button1==true?  Container(
                    height: 600,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:170),
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
                              //if(Listslot=='NO Date'){return Container();}
                              //return Container(child: Text('SARAH'),);
                              //return slot(List1:Listslot,time: widget.time,);
                              // double Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);
                              return new_order(Rate:snapshot.data[index]['Rate'],username:widget.username,ststes:snapshot.data[index]['states'],name:widget.username,id:snapshot.data[index]['id'],index:0,timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],);
                              return Container(child: Text('bggngn'),);
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
                    margin: EdgeInsets.only(top:170),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:FutureBuilder(
                      future: get_not_conferm(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              var Listslot=snapshot.data;
                              //if(Listslot=='NO Date'){return Container();}
                              //return Container(child: Text('SARAH'),);
                              //return slot(List1:Listslot,time: widget.time,);
                              // double Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);
                              return new_order(username:widget.username,ststes:'',name:widget.username,id:snapshot.data[index]['id'],index:1,timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],);
                              return Container(child: Text('bggngn'),);
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ):Container(),
                  button3==true?  Container(
                    height: 600,
                    width: 500,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:170),
                    //padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:FutureBuilder(
                      future: get_delete(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount:snapshot.data.length,
                            itemBuilder: (context, index) {
                              var Listslot=snapshot.data;
                              //if(Listslot=='NO Date'){return Container();}
                              //return Container(child: Text('SARAH'),);
                              //return slot(List1:Listslot,time: widget.time,);
                              // double Rate =roundDouble(double.parse(snapshot.data[index]['AVG']),1);
                              return new_order(username:widget.username,ststes:'',name:widget.username,id:snapshot.data[index]['id'],index:2,datecancel:snapshot.data[index]['datecancel'],timecancel:snapshot.data[index]['timecancel'],timeaccept:snapshot.data[index]['timeaccept'],timesend:snapshot.data[index]['timesend'],dateaccept:snapshot.data[index]['dateaccept'],datesend:snapshot.data[index]['datesend'],description:snapshot.data[index]['description'],phone:snapshot.data[index]['phoneuser'],phoneworker:snapshot.data[index]['phone'],work:snapshot.data[index]['Work'],image:snapshot.data[index]['image'],namefirst:snapshot.data[index]['namefirst'],namelast:snapshot.data[index]['namelast'],date:snapshot.data[index]['date'],timestart:snapshot.data[index]['timestart'] ,timeend:['timeend'],);
                              return Container(child: Text('bggngn'),);
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
  // Future<void> _dialogCall() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //        // return Directionality(textDirection: ui.TextDirection.rtl,
  //         //  child:eaccept_order(image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
  //       });
  // }
}
class new_order  extends StatefulWidget {
  final username;
  final  date;
  final  timeend;
  final  timestart;
  final  Am_Pm;
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
  final index;
  final ststes;
  final Rate;
  //
  new_order({this.Rate,this.username,this.ststes,this.datecancel,this.timecancel,this.index,this.AVG,this.token,this.workertoken,this.timeaccept,this.dateaccept,this.datesend,this.timesend,this.description,this.id,this.country,this.phoneworker,this.work,this.image,this.namefirst,this.namelast,this.name,this.date, this.timeend, this.timestart, this.Am_Pm,this.phone, this.time});

  @override
  _new_order createState() => _new_order();
}
class _new_order extends State<new_order> {
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
        if(widget.index==0){
          print(widget.id);
          print(widget.name);print("ggggggggggggggggg");
        Navigator.push(context, MaterialPageRoute(builder: (context) => current_user_statues(id:widget.id,name_Me:widget.name,AVG:widget.AVG,work:widget.work,timesend:widget.timesend,timeaccept:widget.timeaccept,dateaccept:widget.dateaccept,datesend:widget.datesend,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
        if(widget.index==1){
         Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm_user_statues(name_Me:widget.name,id:widget.id,AVG:widget.AVG,work:widget.work,timesend:widget.timesend,datesend:widget.datesend,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
        if(widget.index==2){
          print(widget.datecancel);
          Navigator.push(context, MaterialPageRoute(builder: (context) => delete_user_statues(AVG:widget.AVG,work:widget.work,timesend:widget.timesend,timecancel:widget.timecancel,datecancel:widget.datecancel,datesend:widget.datesend,date:widget.date,time:timestart+"-"+timeend,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
        }
      },
      child:Container(
        width: 350,
        height: 160,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          ),
         margin: EdgeInsets.only(bottom: 20,),
         padding: EdgeInsets.only(right: 10,top: 10,bottom: 10),
        child:Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 200,
                          alignment: Alignment.topRight,
                          child: Text(name, style: TextStyle(
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
                          child:  Text(work, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontFamily: 'Changa',
                          ),
                          ),
                        ),
                      ],
                    ),
                    widget.ststes=='current'?Container(
                      width: 120,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.10,
                        center: new Text("10%"),
                        progressColor: Colors.green,
                      ),
                    ):Container(),
                    widget.ststes=='notcomplete'?Container(
                      width: 120,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 0.10,
                        center: new Text("10%"),
                        progressColor: Colors.red,
                      ),
                    ):Container(),
                    widget.ststes=='complete'?Container(
                      width: 120,
                      alignment: Alignment.topLeft,
                      child:CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: 1.0,
                        center: new Text("100%"),
                        progressColor: Colors.green,
                      ),
                    ):Container(),
                  ],
                ),

                SizedBox(height:5,),
                Row(
                  children: [
                    Container(
                      width:110,
                      child:Text('التاريخ', style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Changa',
                      ),
                      ),
                    ),
                    Container(
                      width:170,
                      child:Text('الوقت', style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Changa',
                      ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 350,
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Directionality(textDirection: ui.TextDirection.ltr,
                      child:Container(
                      width: 110,
                      alignment: Alignment.topRight,
                      child:Text(date, style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontFamily: 'Changa',
                      ),),),
                      ),
                      Container(child:Row(
                        children: [
                          SizedBox(width: 5,),
                          Text(timestart +"-" +timeend, style: TextStyle(
                            fontSize: 15,
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
                          widget.ststes=='complete'?
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


