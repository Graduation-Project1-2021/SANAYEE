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
import '../buttom_bar.dart';
import '../constants.dart';
import '../database.dart';
import 'State_order_accept.dart';
import 'Worker_not_conferm_order.dart';

String  name_Me="";
String  name="";
String  phone="";
String  image="";
String namefirst="";
String namelast="";
String Country="";
String  token="";
String IP4="192.168.1.8";

class State_order extends StatefulWidget {
  final id;
  final country;
  final namefirst;
  final namelast;
  final image;
  final phoneuser;
  final phoneworker;
  final description;
  final date;
  final time;
  final datesend;
  final timesend;
  final DateTime chooseDate;

  State_order({this.chooseDate,this.id,this.timesend,this.datesend,this.time,this.date,this.country,this.namefirst,this.namelast,this.image,this.phoneuser,this.phoneworker,this.description});
  _State_order createState() =>  _State_order();
}
class  _State_order extends State<State_order> {
  // AnimationController _animationController;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List1 = [];
  var ListDate1 = [];
  final List2 = [];
  var ListDate2 = [];
  var ListBlock=["8.00 - 9.00","9.00 - 10.00","","","",];
  var Listsearch=[];
  bool step1=true;
  bool step2=false;
  bool step3=false;
  bool step4=false;
  @override
  void initState() {
    super.initState();
    // getChat();
  }
  int _selectedIndex = 0;
  PageController _pageController;
  DatabaseMethods databaseMethods=new DatabaseMethods();
  Stream chatsRoom;
  @override
  int _selectedItem = 0;
  Widget build(BuildContext context) {
    print(Listsearch.toString());
    print(widget.phoneworker);
    print('===================================================================================================================================');
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
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 100,
                    decoration: BoxDecoration(
                      // color:ca,
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
                    height: 200,
                    width: 400,
                    margin: EdgeInsets.only(top:120,right: 15,left: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child:Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:0,right: 10),
                          child:Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top:10,right: 10),
                                child:CircleAvatar(backgroundImage: NetworkImage('https://'+IP4+'/testlocalhost/upload/'+widget.image),radius: 25.0,),),
                              Container(
                                margin: EdgeInsets.only(top:0,right: 10),
                                child: Text(widget.namefirst + " "+widget.namelast, style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[600],
                                  fontFamily: 'Changa',
                                ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 390,
                          margin: EdgeInsets.only(top:10,right:20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 5,),
                              // Text(widget.date.toString(), style: TextStyle(
                              //   fontSize: 17,
                              //   fontWeight: FontWeight.w700,
                              //   color: Colors.grey[600],
                              //   fontFamily: 'Changa',
                              // ),),
                              SizedBox(width: 5,),
                              Text(widget.time, style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[600],
                                fontFamily: 'Changa',
                              ),),
                              Text(" "),
                              Text(widget=="am"?"صباحا":"مساء", style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[600],
                                fontFamily: 'Changa',
                              ),),
                            ],
                          ),),
                        Container(
                          width: 400,
                          margin: EdgeInsets.only(right:30),
                          child: Text("تفاصيل الطلب "+widget.description, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            fontFamily: 'Changa',
                          ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2,right: 20),
                          child:Row(
                            children: [
                              Container(
                                width: 55,
                                //padding: EdgeInsets.symmetric(horizontal: 3),
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
                                  color: D,
                                ),
                              ),
                              Container(
                                width: 55,
                                child: FlatButton(
                                  onPressed: () {
                                    //CreatChatRoom();
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
                              Container(
                                width: 55,
                                child: FlatButton(
                                  onPressed: () {
                                    //CreatChatRoom();
                                  },
                                  child: new Icon(
                                    Icons.location_on,
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
                      ],
                    ),
                  ),
                  Container(
                    height: 600,
                    width: 450,
                    // color:  Color(0xFFF3D657),
                    margin: EdgeInsets.only(top:350),
                    padding:EdgeInsets.only(right:25,left: 25),
                    decoration: BoxDecoration(
                      // color:Color(0xFF1C1C1C),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      // ),
                    ),
                    child:SingleChildScrollView(
                      child:Column(
                        children: [
                          GestureDetector(
                            // onTap: (){
                            //   print('fbfgbfbfb');
                            // },
                            child: Row(
                              children: [
                                Container(
                                  height: 110,
                                  width: 350,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child:Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top:5),
                                              alignment: Alignment.topRight,
                                              child:Icon(Icons.check_circle,size: 30,color: step1?Colors.green:Colors.grey,),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top:10),
                                              child:FDottedLine(
                                                color: Colors.green,
                                                height: 60.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('إرسال الطلب',
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('تم بعت الطلب إليك في تاريخ ' + widget.datesend +'\n'+ "في الساعة "+ widget.timesend,
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black45,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _dialogCall();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 110,
                                  width: 350,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child:Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top:5),
                                              alignment: Alignment.topRight,
                                              child:Icon(Icons.check_circle,size: 30,color: step2?Colors.green:Colors.grey,),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top:10),
                                              child:FDottedLine(
                                                color: Colors.green,
                                                height: 60.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('تثبيت الطلب',
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                          ),
                                          // Container(
                                          //   width: 300,
                                          //   margin: EdgeInsets.only(right: 10),
                                          //   child: Text('تم بعت هذا الطلب إليك في تاريخ ' + widget.dateaccept +'\n'+ "في الساعة "+ widget.timeaccept,
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
                                  height: 110,
                                  width: 350,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child:Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top:5),
                                              alignment: Alignment.topRight,
                                              child:Icon(Icons.check_circle,size: 30,color: step3?Colors.green:Colors.grey,),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top:10),
                                              child:FDottedLine(
                                                color: Colors.green,
                                                height: 60.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('البدء في العمل',
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black,
                                                fontSize: 16.0,
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
                                  height: 110,
                                  width: 350,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child:Row(
                                    children:[
                                      Container(
                                        child:Column(
                                          children:[
                                            Container(
                                              margin: EdgeInsets.only(top:5),
                                              alignment: Alignment.topRight,
                                              child:Icon(Icons.check_circle,size: 30,color: step4?Colors.green:Colors.grey,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('الإنتهاء من العمل',
                                              style: TextStyle(
                                                fontFamily: 'Changa',
                                                color: Colors.black,
                                                fontSize: 16.0,
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
                  ),
                  Container(
                    child: Column(
                      children:[
                        Container(
                          width:500,
                          height: 55,
                          margin: EdgeInsets.only(top:742.7,),
                          child: FlatButton(
                            onPressed: (){
                              _dialogCall2();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                side: BorderSide(color: Colors.transparent)
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                            color:Colors.indigo,
                            child: Text(
                              "إلغاء الطلب",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21.0,
                                fontFamily: 'Changa',
                              ),
                            ),
                          ),
                        ),
                      ],),
                  ),
                ],),),
          ),],),);
  }
  Future<void> _dialogCall() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:eaccept_order(image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
        });
  }
  Future<void> _dialogCall2() {
    print(widget.phoneworker);
    print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(textDirection: ui.TextDirection.rtl,
            child:delete_order(phoneworker:widget.phoneworker,chooseDate:widget.chooseDate,image:widget.image,description:widget.description,datesend:widget.datesend,timesend:widget.timesend,id:widget.id,phone:widget.phoneworker,date:widget.date,namefirst: widget.namefirst,namelast:widget.namelast,time:widget.time,),);
        });
  }
}
class eaccept_order extends StatefulWidget {
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
  eaccept_order({this.timeend,this.timestart,this.id,this.phone,this.time,this.date,this.phoneworker,this.phoneuser,this.timesend,this.datesend,this.namelast,this.namefirst,this.description,this.image,this.country});
  _eaccept_order createState() => new _eaccept_order();

}
class _eaccept_order extends State<eaccept_order> {
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.zero,
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            Column(
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 265),
                    child: Icon(Icons.close),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(right: 10,top: 10),
                  child: Text('هل أنت متأكد من أنك تريد قبول هذا الطلب ؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black45,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),),
                 ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          accept_Order();
                          DateTime date=DateTime.now();
                          var formattedDate = DateFormat('yyyy-MM-dd').format(date);
                          var formattedTime = DateFormat('HH:mm:ss').format(date);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => State_order_accept(timesend:widget.timesend,timeaccept:formattedTime,dateaccept:formattedDate,datesend:widget.datesend,date:widget.date,time:widget.time,phoneworker:widget.phoneworker,description:widget.description,namefirst: widget.namefirst,namelast: widget.namelast,phoneuser: widget.phone,image: widget.image,),),);
                         // Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm__order(time: widget.time,phone: widget.phone,)),);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 170),
                            child:Text('نعم',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.black45,
                                fontSize: 15.0,
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
                            child:Text('لا',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: Colors.black45,
                                fontSize: 15.0,
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

  Future accept_Order() async {
    var url = 'https://' + IP4 + '/testlocalhost/acceptorder.php';
    var ressponse = await http.post(url, body: {
      "id": widget.id,
    });
    // ignore: deprecated_member_use
    return json.decode(ressponse.body);
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
  delete_order({this.chooseDate,this.timeend,this.timestart,this.id,this.phone,this.time,this.date,this.phoneworker,this.phoneuser,this.timesend,this.datesend,this.namelast,this.namefirst,this.description,this.image,this.country});
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
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 265),
                    child: Icon(Icons.close),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(right: 10,top: 10),
                  child: Text('هل أنت متأكد من أنك تريد حذف هذا الطلب ؟',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black45,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await delete_Order();
                        DateTime date_d =DateTime.now();
                        print(widget.phoneworker);
                        print('=========================================================================');

                        Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm__order(time:widget.chooseDate,phone:widget.phoneworker,),),);
                        // Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => not_conferm__order(time: widget.time,phone: widget.phone,)),);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 170),
                          child:Text('نعم',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.black45,
                              fontSize: 15.0,
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
                          child:Text('لا',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: Colors.black45,
                              fontSize: 15.0,
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
    DateTime date=DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var formattedTime = DateFormat('HH:mm:ss').format(date);
    var url = 'https://' + IP4 + '/testlocalhost/delete_order.php';
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